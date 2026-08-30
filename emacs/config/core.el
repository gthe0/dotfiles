;;; core.el --- Core UI and sane defaults -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq user-full-name user-full-name)

;; GUI-first.
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(setq-default indent-tabs-mode nil
              tab-width 8
              truncate-lines t)

(setq ring-bell-function #'ignore
      use-dialog-box nil
      use-short-answers t
      delete-selection-mode t
      confirm-kill-emacs nil
      sentence-end-double-space nil
      require-final-newline t
      compilation-scroll-output t
      save-interprogram-paste-before-kill t
      x-select-enable-clipboard t
      select-enable-clipboard t
      mouse-yank-at-point t
      backup-by-copying t
      create-lockfiles nil
      auto-save-default t
      make-backup-files nil
      inhibit-startup-screen t)

(setq display-line-numbers-type 'relative)

;; Sensible modern scrolling.
(setq scroll-conservatively 10
      scroll-margin 3
      scroll-preserve-screen-position t
      pixel-scroll-precision-mode t)

;; UTF-8 everywhere.
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; Theme: Modus is built into Emacs 31.  Do not install it as a package.
(require-theme 'modus-themes)
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil)
(load-theme 'modus-vivendi t)

(global-set-key (kbd "<f5>") #'modus-themes-toggle)

;; Make Escape a reliable cancel key.
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

;; Modern editing defaults.
(delete-selection-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 1)

;; Prefer spaces when programming.
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode nil)))

;; Helpful built-ins.
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)

;; Bidirectional text scanning
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Skip fontification during input
(setq redisplay-skip-fontification-on-input t)

;; Do not render the cursor in non selected windows
;; (less practical but looks nice)
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; This shit does not work as intended
(setq electric-indent-mode nil)

;; Recentf settings
(setq recentf-max-saved-items 300
      history-length 500
      save-place-forget-unreadable-files nil)

;; Keep customization out of init.el.
(setq custom-file (expand-file-name "custom.el"
                                    (or (bound-and-true-p cfg-local-dir)
                                        (expand-file-name "local/" user-emacs-directory))))

;; When I use compilation mode, I would like it to switch windows automatically
(defun pck/switch-to-other-window (buffer status)
  "Select the window displaying BUFFER, after compilation changes its STATUS."
  (let ((win (get-buffer-window buffer)))
    (when win
      (select-window win))))

(add-hook 'compilation-finish-functions #'pck/switch-to-other-window)

;; UTF-8 encoding things (Prot's standard)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

(provide 'core)
;;; core.el ends here
