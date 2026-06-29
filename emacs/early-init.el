;;; early-init.el --- Early Initialization Config -*- lexical-binding: t -*-

;; 1. Prevent GUI Elements from Ever Flashing On Screen
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil
      tooltip-mode nil)

;; 2. Set Up Initial & Default Frame Settings (Prot Style)
;; Declaring these here means the window spawns directly with these parameters.
(setq initial-frame-alist
      '((vertical-scroll-bars . nil)
        (horizontal-scroll-bars . nil)
        (tool-bar-lines . 0)
        (menu-bar-lines . 0)
        (background-color . "#1e1e1e"))) ; Match dark theme background to stop white flashes

(setq default-frame-alist initial-frame-alist)

;; 3. Core UI Speedups & Inhibitions
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-default-init t

      ;; package related settings
      package-enable-at-startup t
      package-quickstart t
      

      ;; Stop the ringing
      ring-bull-function #'ignore)

;; 4. File-name Handler Deferral (Massive Startup Boost)
(defvar cfg/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda () (setq file-name-handler-alist cfg/saved-file-name-handler-alist)))

;; 5. Max Out Garbage Collection Threshold For Startup
(defvar cfg/gc-cons-threshold (* 16 1024 1024))
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

