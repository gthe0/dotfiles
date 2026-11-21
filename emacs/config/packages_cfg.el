;;; packages_cfg.el --- Central package orchestrator -*- lexical-binding: t; -*-

;;; Commentary:
;; Scans the config/pkg/ directory, reads top-line manifests, 
;; batch-installs missing packages, and loads module configurations.

;;; Code:

(require 'package)

;; Define full package archives including MELPA for modern plugins
(setq package-archives
      '(("gnu"          . "https://elpa.gnu.org/packages/")
        ("nongnu"       . "https://elpa.nongnu.org/nongnu/")
        ("melpa"        . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

(defun pkg/read-file-spec (file)
  "Read and evaluate the first expression from the top of FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (condition-case nil
        ;; Evaluate the read form so '(pkg1 pkg2) unwraps correctly
        (eval (read (current-buffer)) t)
      (error nil))))

(defun pkg/ensure-packages-installed (packages)
  "Ensure a list of PACKAGES are installed."
  (let ((to-install (cl-remove-if #'package-installed-p packages)))
    (when to-install
      (unless package-archive-contents
        (message "Refreshing package metadata...")
        (package-refresh-contents))
      (dolist (pkg to-install)
        (message "Installing package: %s" pkg)
        (package-install pkg)))))

(defun pkg/load-package-modules ()
  "Scan config/pkg/, collect package manifests, batch-install, and load."
  (let ((pkg-dir (expand-file-name "config/pkg/" user-emacs-directory))
        all-packages)
    (when (file-directory-p pkg-dir)
      ;; Pass 1: Read package lists from the top of all module files
      (dolist (file (directory-files pkg-dir t "\\.el$"))
        (let ((spec (pkg/read-file-spec file)))
          (when (consp spec)
            (setq all-packages (append all-packages spec)))))

      ;; Pass 2: Batch install every required package safely
      (pkg/ensure-packages-installed all-packages)

      ;; Pass 3: Load the actual module configuration files
      (dolist (file (directory-files pkg-dir t "\\.el$"))
        (load file nil 'nomessage))
      
      (message "All package modules initialized successfully."))))

(pkg/load-package-modules)

(provide 'packages_cfg)
;;; packages_cfg.el ends here
