;;; ========== GENERAL SETTINGS =================

;; Disable tool-bar and menu-bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)

;; Quality of life settings
(display-line-numbers-mode t)
(show-paren-mode t)

;; Backup-files settings
(setq make-backup-files nil) ; prevent emacs from creating backup-file ending with nil

;;Ido mode 
(ido-mode t)

;;; ========== PACKAGE SETTINGS =================

;; Configure package.el to include MELPA.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Loaded Config Files
(load "~/emacs.d/emacs.pck/themes.el")
