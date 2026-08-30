;;; init.el --- Emacs 31.1 configuration entry point -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Exact semantic version check: 31.1 itself is accepted.
(unless (version<= "31.1" emacs-version)
  (error "This configuration requires Emacs 31.1 or newer"))

(defconst cfg-root user-emacs-directory)
(defconst cfg-dir (expand-file-name "config/" cfg-root))
(defconst cfg-local-dir (expand-file-name "local/" cfg-root))
(defconst cfg-user-lisp-dir
  (if (boundp 'user-lisp-directory)
      user-lisp-directory
    (expand-file-name "user-lisp/" cfg-root)))

(add-to-list 'load-path cfg-dir)
(add-to-list 'load-path cfg-user-lisp-dir)

;; Restore anything temporarily removed by early-init.el.
(when (boundp 'cfg--saved-file-name-handler-alist)
  (setq file-name-handler-alist cfg--saved-file-name-handler-alist)
  (makunbound 'cfg--saved-file-name-handler-alist))

;; package.el is built in.  We do not call package-initialize: package.el
;; initializes itself on first use in modern Emacs.
(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Load local customization separately so it can be kept machine-specific.
(load (expand-file-name "custom.el" cfg-local-dir) t t)

;; Configuration modules all use the cfg- prefix so they cannot collide with
;; Emacs libraries such as completion.el, files.el, windows.el, etc.
(require 'core)
(require 'packages)
(require 'editing)
(require 'completion_cfg)
(require 'windows)
(require 'files)
(require 'diagnostics)
(require 'languages)
(require 'terminal)

;; Return GC to a normal interactive value after startup.
(setq gc-cons-threshold (* 32 1024 1024)
      gc-cons-percentage 0.1)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)
            (message "Emacs ready in %.2fs with %d GCs"
                     (float-time (time-subtract after-init-time before-init-time))
                     gcs-done)))

;;; init.el ends here
