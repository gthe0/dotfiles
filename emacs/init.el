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

;; Create a custom file to not clutter init.el
(setq custom-file "~/.emacs.d/local/custom-set.el")
(load custom-file 'noerror)

;; load files
(require 'config)
(require 'packages)
(require 'languages)
(require 'platform)
