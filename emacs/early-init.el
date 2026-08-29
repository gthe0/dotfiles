;;; early-init.el --- Minimal Emacs 31.1 startup -*- lexical-binding: t; -*-

;; Keep this file deliberately small.  Do not put normal package/configuration
;; setup here: early-init runs before the GUI/frame and package initialization.

(setq package-enable-at-startup nil)

;; Avoid expensive GC during startup.  The normal value is restored in init.el
;; after initialization has finished.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Emacs 31 provides user-lisp-directory.  Add it when available, but do not
;; call prepare-user-lisp here: that is filesystem work and does not belong in
;; the early-init path.
(when (boundp 'user-lisp-directory)
  (add-to-list 'load-path user-lisp-directory))

;; Windows can spend noticeable time processing these during startup.
;; This is restored by normal startup; importantly, we do not permanently
;; modify the user's file-name-handler-alist.
(defvar cfg--saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; GUI-first: avoid unnecessary menu-bar/toolbar work while the initial frame
;; is being created.  The final UI settings live in config/cfg-core.el.
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      frame-inhibit-implied-resize t)

;;; early-init.el ends here
