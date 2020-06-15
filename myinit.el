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
           (setq mac-command-modifier 'meta)))
;; turn off Simultaneous Editing
(setq create-lockfiles nil)

;; all backups goto ~/.backups instead in the current directory
(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.emacs.d/backup"))
      delete-old-versions t
      kept-new-versions 3
      kept-old-versions 1
      version-control t)

;;auto-save
(setq-default auto-save-timeout 15) ; 15秒无动作,自动保存
(setq-default auto-save-interval 100) ; 100个字符间隔, 自动保存

;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 0 0)
;;设置宽和高
(set-frame-width (selected-frame) 170)
(set-frame-height (selected-frame) 80)

;; 最大化窗口
;;(add-to-list 'default-frame-alist '(fullscreen . fullboth))
;;(add-hook 'window-setup-hook 'toggle-frame-maximized t)
;;(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

(electric-pair-mode t)

(setq fonts
      (cond ((eq system-type 'darwin)     '("Monaco"    "STHeiti"))
            ((eq system-type 'gnu/linux)  '("Menlo"     "STHeiti"))
            ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei"))))
(set-face-attribute 'default nil :font
                    (format "%s:pixelsize=%d" (car fonts) 14))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family (car (cdr fonts)))))
;;Fix chinese font width and rescale
(setq face-font-rescale-alist '(("Microsoft Yahei" . 1.2) ("WenQuanYi Micro HeiMono" . 1.2) ("STHeiti". 1.2)))

;;(use-package org-bullets
;;  :ensure t
;;  :config
;;  (add-hook 'org-mode-hook #'org-bullets-mode))

;; set org-file-apps?
;; (setq org-file-apps
;;       (append '(
;;                 ("\\.pdf\\'" . "evince %s")
;;                 ("\\.x?html?\\'" . "/usr/bin/firefox %s")
;;                 ) org-file-apps ))

;;key bind and some stuff
(global-set-key "\C-ca" 'org-agenda)
(setq org-agenda-start-on-weekday nil)
;;load agenda files
(setq org-agenda-files (list "~/Dropbox/org/*.org"))

;;use org-ac auto-complete for org
(use-package org-ac
  :ensure t
  :init (progn
          (require 'org-ac)
          (org-ac/config-default)
          ))
    ;;set key bind to C-c c
(global-set-key (kbd "C-c c") 'org-capture)

;;set org capture templates
(setq org-capture-templates
      '(("l" "Link" entry (file+headline "~/Dropbox/org/inbox.org" "Links")
         "* %? %^L %^g \n%T" :prepend t)
        ("t" "To-Do Item" entry (file+headline "~/Dropbox/org/inbox.org" "To-Do")
         "* TODO %?\n%u" :prepend t)
        ("n" "Note" entry (file+headline "~/Dropbox/org/inbox.org" "Notes")
         "* %u %? " :prepend t)
        ))

;;images support
(use-package org-download
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq org-download-heading-lvl nil)
  (setq-default org-download-image-dir "~/Dropbox/org/images")
  )
;; set defauly img width in org
(setq org-image-actual-width 500)


;; (defun after-org-mode-loaded()
;;   (setq org-download-heading-lvl nil)
;;   (if buffer-file-name
;;       (let ((org-img-base-folder "~/Dropbox/org/images")
;;             (img-folder (format "%s/%s" org-img-base-folder (file-name-base buffer-file-name))))
;;         (setq-local org-download-image-dir img-folder))
;;     ))

;; use htmlize
(use-package htmlize :ensure t)
(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("blog-notes"
         :base-directory "~/Dropbox/org/notes/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/org/html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 2
         :auto-preamble t
         :section-numbers nil
         :author "Enke"
         :email "enke000@gmail.com"
         :auto-sitemap t                  ; 自动生成 sitemap.org 文件
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d %t"
         )
        ("blog-static"
         :base-directory "~/Dropbox/org/notes/"
         :base-extension "css|js|png|jpg|gif|pdf|mp3|ogg|swf"
         :publishing-directory "~/Dropbox/org/html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("blog-notes" "blog-static"))
        ))

;;deft emacs
(use-package deft
  :ensure t
  :bind ("C-c d" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Dropbox/org/notes"
                deft-extensions '("md" "org")
                deft-recursive t
                deft-extensions '("txt" "tex" "org" "md")
                deft-file-naming-rules '((noslash . "-"))
                deft-text-mode 'org-mode
                deft-use-filter-string-for-filename t
                deft-strip-summary-regexp
                (concat "\\("
                        "[\n\t]" ;; blank
                        "\\|^#\\+[[:upper:]_]+:.*$" ;; org-mode metadata
                        "\\|^#\\+[[:alnum:]_]+:.*$" ;; org-mode metadata
                        "\\)")))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

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

(use-package elpy
  :ensure t
  :config
      (elpy-enable))

;;(setq python-shell-interpreter "~/.pyenv/shims/python")

(use-package pyenv-mode
  :ensure t)

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
      (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

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

(defun now ()
  "Insert string for the current time formatted like '2:34 PM' or 1507121460"
  (interactive)                 ; permit invocation in minibuffer
  ;;(insert (format-time-string "%D %-I:%M %p")))
  (insert (format-time-string "%-I:%M %p")))
  ;;(insert (format-time-string "%02y%02m%02d%02H%02M%02S")))
  ;;(insert (format-time-string "%02y%02m%02d%02H%02M")))

(global-set-key "\C-xt" 'now)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("org" (name . "^.*org$"))

               ("web" (or (mode . web-mode) (mode . js2-mode)))
               ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
               ("mu4e" (name . "\*mu4e\*"))
               ("programming" (or
                               (mode . python-mode)
                               (mode . c++-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
;;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  )
