;;; ========== PACKAGE SETTINGS =================

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Utility functions 
(defun rc/use-package (pkg &optional enable)
  (straight-use-package pkg)
  (when enable (require pkg)))

(defun rc/use-packages (&rest packages)
  (dolist (pkg packages) 
    rc/enable-package(pkg t)))

(defun rc/use-theme (theme)
  (let* ((name (symbol-name theme))
         (pkg  (intern (concat name "-theme"))))
    (rc/enable-package pkg)
    (load-theme theme  t)))

;;
;;;; ido-completing-read+
;;(use-package ido-completing-read+
;;  :straight t
;;  :config
;;  (require 'ido-completing-read+)
;;  (ido-ubiquitous-mode t))
;;
;;;; smex-mode
;;(use-package smex
;; :straight t
;; :bind ("M-x" . smex))
;;
;;;; magit
;;(use-package cl-lib
;;  :straight t)
;;
;;(use-package magit
;;  :straight t
;;  :bind ("C-c m s" . magit-status)
;;  ("C-c m l" . magit-log))
;;
;;;; Move-text
;;(use-package move-text
;;  :straight t
;;  :bind (("M-n" . move-text-down)
;;	 ("M-p" . move-text-up))
;;  :config (move-text-default-bindings))
;;
;;;; yasnipet
;;(use-package yasnippet-snippets
;;  :straight t
;; )
;;(use-package yasnippet
;;  :straight t
;;  :config
;;  (yas-global-mode 1))
