;;; ========== GENERAL SETTINGS =================
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

;;; ========== CONFIGURING PLUGINS =================
(load "~/.emacs.d/rc.el")

;; ido-completing-read+
(use-package ido-completing-read+
  :straight t
  :config
  (require 'ido-completing-read+)
  (ido-ubiquitous-mode t))

;; smex-mode
(use-package smex
 :straight t
 :bind ("M-x" . smex))

;; magit
(use-package cl-lib
  :straight t)

(use-package magit
  :straight t
  :bind ("C-c m s" . magit-status)
  ("C-c m l" . magit-log))

;; Move-text
(use-package move-text
  :straight t
  :bind (("M-n" . move-text-down)
	 ("M-p" . move-text-up))
  :config (move-text-default-bindings))

;; yasnipet
(use-package yasnippet-snippets
  :straight t)

(use-package yasnippet
  :straight t
  :config
  (yas-global-mode 1))



