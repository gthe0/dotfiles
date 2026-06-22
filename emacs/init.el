;;; init.el --- gtheo's Emacs setup. -*- lexical-binding: t; -*-
;;
;; This file is the root file initializing my configuration
;;
;;; ======== Config ========

;; Define Configuration Directory -- Contains general configurations
(defvar config-dir
  (expand-file-name "config" user-emacs-directory))

;; Auto-load dirs
(add-to-list 'load-path config-dir)

;; load files
(require 'config)
(require 'my-packages)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

