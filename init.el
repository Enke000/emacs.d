;;add elpa.org
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://elpa.emacs-china.org/melpa/")
	     '("gnu"   . "http://elpa.emacs-china.org/gnu/"))

;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;  			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/org/inbox.org")))
 '(org-confirm-babel-evaluate nil)
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-directory "~/Dropbox/org")
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-image-actual-width nill)
 '(org-src-fontify-natively t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (org-pdftools pdf-tools pdf-tool org-pdfview org-pomodoro emmet-mode counsel-projectile projectile exec-path-from-shell pyenv-mode deft zenburn-theme which-key web-mode use-package try org-download org-bullets org-ac noflet jedi iedit hungry-delete htmlize flycheck expand-region elpy counsel cnfonts beacon ace-window))))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
(put 'narrow-to-region 'disabled nil)
