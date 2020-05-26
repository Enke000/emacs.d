;;hide startup massage
(setq inhibit-startup-message t)
;; close backup 
(setq make-backup-files nil)

;;add elpa.org
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;using 'try'
(use-package try
  :ensure t)

;; using 'which-key'
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; org-mode stuff
;; useing org-bullets, can show outline as bullets in org-mode
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode))



;; auto generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org-bullets which-key use-package try))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
