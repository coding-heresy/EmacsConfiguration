;; Site-specific values

(setq base-user-dir "/home/bd")

(setq base-src-dir (concat base-user-dir "/src"))

(setq base-emacs-plugin-dir (concat base-user-dir "/.emacs.d/plugins"))

(setq user-mail-address "bd@jollyrogerlabs.com")

(setq copyright-str (concat "Copyright "
			    (format-time-string "%Y")
			    " by Brian Davis, all rights reserved."))

(setq java-home "")

(setq gcode-mode-plugin-location (concat base-emacs-plugin-dir "/gcode-emacs/gcode.el")

;; Load cedet from installed version very early.
(load-file (concat base-user-dir "/.emacs.d/plugins/cedet/cedet-devel-load.el"))

;; Use my-site-start to load modularized emacs configuration.
(autoload 'my-site-start (concat base-user-dir "/.emacs.d/plugins/my-site-start") nil t)
(my-site-start (concat base-user-dir "/.emacs.d/local-start.d/"))

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
