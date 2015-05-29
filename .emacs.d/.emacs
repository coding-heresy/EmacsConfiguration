;; Site-specific values

(setq *user-name* "Brian Davis")

(setq *base-user-dir* "")

(setq *base-src-dir* (concat *base-user-dir* ""))

(setq user-mail-address "")

(setq copyright-str (concat "Copyright "
			    (format-time-string "%Y")
			    " by " *user-name* ", all rights reserved."))

(setq java-home "")

(setq *has-cedet* t)

(setq *has-gcode-emacs* t)

(setq *has-flymake-cursor* t)

(setq *has-graphviz-dot-mode* t)




;; Early operations that are based on site-specific values
(setq *base-emacs-plugin-dir* (concat *base-user-dir* "/.emacs.d/plugins"))

(add-to-list 'load-path (concat *base-emacs-plugin-dir*))
(if *has-gcode-emacs*
    (add-to-list 'load-path (concat *base-emacs-plugin-dir* "/gcode-emacs/")))

;; Load cedet from installed version very early.
(if *has-cedet*
    (load-file (concat *base-emacs-plugin-dir* "/cedet/cedet-devel-load.el"))
  )

;; Use my-site-start to load modularized emacs configuration.
(autoload 'my-site-start (concat *base-emacs-plugin-dir* "/my-site-start") nil t)
(my-site-start (concat *base-user-dir* "/.emacs.d/local-start.d/"))

;; Use FSF compliant keybindings (instead of <C-z> prefix) for ilisp.
(setq ilisp-*use-fsf-compliant-keybindings* t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(warning-suppress-types (quote ((undo discard-info)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(outline-2 ((t (:foreground "DarkGoldenrod")))))
