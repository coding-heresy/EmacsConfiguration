
(setq *user-name* "Brian Davis")

;; Site-specific values

(setq *base-user-dir* "/home/bd")

(setq *base-src-dir* (concat *base-user-dir* "/src"))

(setq *user-mail-address* "brian8702@sbcglobal.net")

(setq *copyright-str* (concat "Copyright (C) "
			      (format-time-string "%Y")
			      " by " *user-name*))

(setq *has-flymake-cursor* t)

(setq *has-graphviz-dot-mode* t)

(setq java-home "")



;; Early operations that are based on site-specific values
(setq *base-emacs-plugin-dir* (concat *base-user-dir* "/.emacs.d/plugins"))

(add-to-list 'load-path (concat *base-emacs-plugin-dir*))

;; Use my-site-start to load modularized emacs configuration.
(autoload 'my-site-start (concat *base-user-dir* "/.emacs.d/plugins/my-site-start") nil t)
(my-site-start (concat *base-user-dir* "/.emacs.d/local-start.d/"))

;; Use FSF compliant keybindings (instead of <C-z> prefix) for ilisp.
(setq ilisp-*use-fsf-compliant-keybindings* t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit cmake-mode))
 '(warning-suppress-types '((undo discard-info))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(outline-2 ((t (:foreground "DarkGoldenrod")))))
