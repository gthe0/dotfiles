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

