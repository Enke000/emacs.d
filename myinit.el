;;hide startup massage
(setq inhibit-startup-message t)
;; close
(setq make-backup-files nil)
;;hide tool bar
(tool-bar-mode -1)
;; use y-n-p over yes-no-p
(fset 'yes-or-no-p 'y-or-n-p)
;;reload buffer use F5
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)
;;list buffers
(defalias 'list-buffers 'ibuffer)
;;set command-key to meta
(if (eq system-type 'darwin)
    (progn (setq mac-option-modifier 'super)
           (setq mac-command-modifier 'meta))
  (pass))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode))

(setenv "BROWSER" "safari")

;; set org files directory
(custom-set-variables
 '(org-directory "~/Dropbox/org")
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(org-confirm-babel-evaluate nil)
 '(org-src-fontify-natively t)
 )

;;set org-file-apps?
(setq org-file-apps
      (append '(
                ("\\.pdf\\'" . "evince %s")
                ("\\.x?html?\\'" . "/usr/bin/firefox %s")
                ) org-file-apps ))

;;key bind and some stuff
(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))

;;use org-ac auto-complete for org
(use-package org-ac
  :ensure t
  :init (progn
          (require 'org-ac)
          (org-ac/config-default)
          ))
;;set key bind to C-c c
(global-set-key (kbd "C-c c") 'org-capture)

;;load agenda files
(setq org-agenda-files (list "~/Dropbox/org/gcal.org"
                             "~/Dropbox/org/i.org"
                             "~/Dropbox/org/schedule.org"
                             "~/Dropbox/org/notes.org"))

;;set org capture templates
(setq org-capture-templates
      '(("a" "Appointment" entry (file  "~/Dropbox/org/gcal.org" )
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ("l" "Link" entry (file+headline "~/Dropbox/org/links.org" "Links")
         "* %? %^L %^g \n%T" :prepend t)
        ("b" "Blog idea" entry (file+headline "~/Dropbox/org/i.org" "Blog Topics:")
             "* %?\n%T" :prepend t)
        ("t" "To Do Item" entry (file+headline "~/Dropbox/org/i.org" "To Do and Notes")
         "* TODO %?\n%u" :prepend t)
        ("m" "Mail To Do" entry (file+headline "~/Dropbox/org/i.org" "To Do and Notes")
         "* TODO %a\n %?" :prepend t)
        ("g" "GMail To Do" entry (file+headline "~/Dropbox/org/i.org" "To Do and Notes")
         "* TODO %^L\n %?" :prepend t)
        ("n" "Note" entry (file+headline "~/Dropbox/org/i.org" "Notes")
         "* %u %? " :prepend t)
        ))

;;All the below is capture frame setting
(defadvice org-capture-finalize 
    (after delete-capture-frame activate)  
  "Advise capture-finalize to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))

(defadvice org-capture-destroy 
    (after delete-capture-frame activate)  
  "Advise capture-destroy to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))  

(use-package noflet
  :ensure t )
(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
          (org-capture)))
;; (require 'ox-beamer)
;; for inserting inactive dates
    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

(use-package htmlize :ensure t)

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    ;;change faces of ace-window
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

(use-package swiper
  :ensure try
  :bind(("C-s" . swiper)
	("C-r" . swiper)
	("C-c C-r" . ivy-resume)
	("M-x" . counsel-M-x)
	("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package avy
  :ensure t
  :bind("M-s" . avy-goto-char))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;;(use-package htmlize
  ;;:ensure t)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(global-hl-line-mode t)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  ;;(setq beacon-color "#666600")
  )

(setq save-interprogram-paste-before-kill t)

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package iedit
  :ensure t)

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
	'(("django"    . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t)) ; this fixes the quote problem I mentioned

(defadvice handle-delete-frame (around my-handle-delete-frame-advice activate)
  "Hide Emacs instead of closing the last frame"
  (let ((frame   (posn-window (event-start event)))
        (numfrs  (length (frame-list))))
    (if (> numfrs 1)
        ad-do-it
      (do-applescript "tell application \"System Events\" to tell process \"Emacs\" to set visible to false"))))
