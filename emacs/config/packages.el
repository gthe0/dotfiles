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
;;
;; Optional Packages:
;;   doom-themes      - various themes used in doom emacs
;;   multiple-cursors - Multiple cursors functionality 
;; 
;; Built-in Packages:
;;   Modus themes, Eglot, Flymake, Project, Xref, Dired/Wdired,
;;   compilation, Eshell, Tree-sitter modes and native completion are
;;   supplied by Emacs 31.1 itself.

;;; Code:

(require 'package)

;; ---------------------------------------------------------------------------
;; Package archives
;; ---------------------------------------------------------------------------

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")
        ("melpa-stable"  . "https://stable.melpa.org/packages/")))

;; Do not call package-refresh-contents on every startup.
(package-initialize)

;; ---------------------------------------------------------------------------
;; Required external packages
;; ---------------------------------------------------------------------------

(defconst pkg/required-packages
  '(vertico
    orderless
    marginalia
    corfu
    consult)
  "Packages required by the configuration.")

(defconst pkg/optional-packages
  '(doom-themes
    multiple-cursors
    cmake-mode)
    "Packages that may be installed for optional functionality.")

(defun pkg/package-refresh-contents-if-needed ()
  "Refresh package metadata if it is not available."
  (unless package-archive-contents
    (message "Refreshing package contents...")
    (package-refresh-contents)))

(defun pkg/ensure-package-installed (package)
  "Install PACKAGE if it is not already installed."
  (unless (package-installed-p package)
    (pkg/package-refresh-contents-if-needed)
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
(dolist (package pkg/required-packages)
  (pkg/ensure-package-installed package))

;; Package configuration

(require 'vertico)
(vertico-mode 1)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides
      '((file (styles orderless partial-completion))
        (command (styles orderless basic))
        (symbol (styles orderless basic))
        (variable (styles orderless basic))
        (function (styles orderless basic))))

(require 'marginalia)
(marginalia-mode 1)

(require 'consult)

;; Enable auto completion, configure delay, trigger and quitting
(require 'corfu)
(setq corfu-auto t
      corfu-cycle t
      corfu-preselect 'prompt
      corfu-preview-current t
      corfu-scroll-margin 5
      corfu-count 10
      corfu-preselect 'first
      corfu-auto-prefix 4
      ;; Tab behaviour
      tab-always-indent 'complete)

(global-corfu-mode 1)

;; Optional packages
(dolist (package pkg/optional-packages)
  (pkg/ensure-package-installed package))

(load-theme 'doom-dark+ t)

;; multiple cursors setup 
(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m l") 'mc/edit-lines)

(provide 'packages)
;;; packages.el ends here
