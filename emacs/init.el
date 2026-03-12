;;; ========== GENERAL SETTINGS =================
(load "~/.emacs.d/rc.el")

(show-paren-mode 1)
(column-number-mode 1)

;; Disable tool-bar and menu-bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(setq inhibit-startup-message 1) 
(setq initial-scratch-message 0)

(global-display-line-numbers-mode 1)
(display-line-numbers-mode 1)			     
(show-paren-mode 1)

;; Disable Backups etc
(setq make-backup-files 0)
(setq auto-save-default 0)
(setq create-lockfiles 0)


;; Disable beeping sound on windows
(setq visible-bell 1)
(delete-selection-mode 1)

;;Ido mode
(ido-mode 1)
(ido-everywhere 1)

;;; ========== LOADING CONFIGS =================
