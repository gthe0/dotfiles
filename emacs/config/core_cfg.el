;;; core_cfg.el --- Core UI and sane defaults -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq user-full-name user-full-name)

;; GUI-first.
(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode t)
(global-display-line-numbers-mode t)

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
      auto-save-default nil
      make-backup-files nil
      inhibit-startup-screen t)

(setq display-line-numbers-type 'relative)

;; Sensible modern scrolling.
(setq scroll-conservatively 10
      scroll-margin 3
      scroll-preserve-screen-position t
      pixel-scroll-precision-mode t)

;; Make Escape a reliable cancel key.
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

;; Modern editing defaults.
(delete-selection-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 1)

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

;; Make electric indentation behave properly
(setq electric-indent-inhibit t)

;; Recentf settings
(setq recentf-max-saved-items 300
      history-length 500
      save-place-forget-unreadable-files nil)

;; Set default font
(defcustom cfg/preferred-fonts
  '("Iosevka Mono" "Iosevka" "Consolas" "monospace")
  "List of preferred fonts for the editor, in order of preference."
  :type '(repeat string)
  :group 'convenience)

(defcustom cfg/font-size 13
  "Preferred font size in points."
  :type 'integer
  :group 'convenience)

(defun cfg/get-available-font (font-list)
  "Iterate through FONT-LIST and return the first one installed on the system."
  (seq-find (lambda (font)
              (member font (font-family-list)))
            font-list))

(defun cfg/apply-font (font size)
  "Apply FONT at the given SIZE to the current frame and set it as default."
  (when font
    ;; `set-frame-font` remains the standard, robust way to handle this nowadays.
    (set-frame-font (format "%s %d" font size) nil t)
    (message "Applied font: %s (size %d)" font size)))

(defun cfg/set-editor-font ()
  "Set the editor font using `cfg/preferred-fonts' and `cfg/font-size'."
  (interactive)
  (if-let* ((font (cfg/get-available-font cfg/preferred-fonts)))
      (cfg/apply-font font cfg/font-size)
    (warn "None of the preferred fonts were found on this system!")))

(cfg/set-editor-font)

;; Keep customization out of init.el.
(setq custom-file (expand-file-name "custom.el"
                                    (or (bound-and-true-p cfg-local-dir)
                                        (expand-file-name "local/" user-emacs-directory))))

;; UTF-8 encoding things (Prot's standard)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-language-environment "UTF-8")

(provide 'core_cfg)
;;; core_cfg.el ends here
