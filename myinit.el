;;hide startup massage
(setq inhibit-startup-message t)
;; close backup 
(setq make-backup-files nil)
;;hide tool bar
(tool-bar-mode -1)
;; use y-n-p over yes-no-p
(fset 'yes-or-no-p 'y-or-n-p)
;;reload buffer use F5
(global-set-key (kbd "<f5>") 'revert-buffer)
;;list buffers
(defalias 'list-buffers 'ibuffer)

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
  )
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
