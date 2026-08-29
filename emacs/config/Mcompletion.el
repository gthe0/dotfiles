;;; cfg-completion.el --- Native completion, no Company -*- lexical-binding: t; -*-

(require 'completion)
(require 'icomplete)

;; Do not make a popup appear after every character.  TAB/manual completion is
;; the reliable baseline for Windows and Eglot.
(setq completion-cycle-threshold 3
      completion-auto-help 'visible
      completion-show-help nil
      completion-ignore-case t
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t
      tab-always-indent 'complete
      completion-styles '(basic))

;; Vertico/Orderless, when installed, alter the minibuffer side.  In-buffer
;; completion remains native completion-at-point.
(global-set-key (kbd "C-M-i") #'completion-at-point)

;; Optional built-in inline preview.  Disabled by default until the Eglot
;; setup has been verified on Windows.
(defun cfg/enable-completion-preview ()
  "Enable Emacs's built-in inline completion preview in the current buffer."
  (interactive)
  (if (fboundp 'completion-preview-mode)
      (completion-preview-mode 1)
    (user-error "completion-preview-mode is unavailable in this Emacs build")))

(defun cfg/disable-completion-preview ()
  "Disable completion preview in the current buffer."
  (interactive)
  (when (fboundp 'completion-preview-mode)
    (completion-preview-mode -1)))

;; Useful minibuffer behavior without another completion engine.
(when (fboundp 'icomplete-vertical-mode)
  (setq icomplete-prospects-height 10
        icomplete-separator "  "
        icomplete-hide-common-prefix nil)
  ;; Vertico is preferred when installed, so leave Icomplete off by default.
  )

(provide 'Mcompletion)
;;; cfg-completion.el ends here
