;;; packages.el --- Package setup for Emacs 31.1 -*- lexical-binding: t; -*-

;;; Commentary:
;; Package bootstrap for the configuration.
;;
;; External packages are installed automatically on first startup.
;; Built-in Emacs 31.1 functionality is NOT installed through package.el.
;;
;; External packages used by the configuration:
;;   vertico     - minibuffer completion UI
;;   orderless   - flexible completion matching
;;   marginalia  - minibuffer annotations
;;   consult     - enhanced search/navigation commands
;;   dirvish     - modern Dired interface
;;
;; Optional:
;;   apheleia    - asynchronous formatting
;;
;; Modus themes, Eglot, Flymake, Project, Xref, Dired/Wdired,
;; compilation, Eshell, Tree-sitter modes and native completion are
;; supplied by Emacs 31.1 itself.

;;; Code:

(require 'package)

;; ---------------------------------------------------------------------------
;; Package archives
;; ---------------------------------------------------------------------------

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa-stable"  . "https://stable.melpa.org/packages/")))

;; Do not call package-refresh-contents on every startup.
(package-initialize)

;; ---------------------------------------------------------------------------
;; Required external packages
;; ---------------------------------------------------------------------------

(defconst my/required-packages
  '(vertico
    orderless
    marginalia
    consult
    dirvish)
  "Packages required by the configuration.")

(defconst my/optional-packages
  '(apheleia)
  "Packages that may be installed for optional functionality.")

(defun my/package-refresh-contents-if-needed ()
  "Refresh package metadata if it is not available."
  (unless package-archive-contents
    (message "Refreshing package contents...")
    (package-refresh-contents)))

(defun my/ensure-package-installed (package)
  "Install PACKAGE if it is not already installed."
  (unless (package-installed-p package)
    (my/package-refresh-contents-if-needed)
    (condition-case err
        (progn
          (message "Installing package: %s" package)
          (package-install package)
          (message "Installed package: %s" package))
      (error
       (error "Could not install package %s: %s"
              package
              (error-message-string err))))))

;; Install only packages that are actually required.
(dolist (package my/required-packages)
  (my/ensure-package-installed package))

;; Package configuration

(require 'vertico)
(vertico-mode 1)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides
      '((file (styles partial-completion))))

(require 'marginalia)
(marginalia-mode 1)

(require 'consult)

(require 'dirvish)
(dirvish-override-dired-mode)

;; Optional packages

(dolist (package my/optional-packages)
  (my/ensure-package-installed package))

(provide 'packages)
;;; packages.el ends here
