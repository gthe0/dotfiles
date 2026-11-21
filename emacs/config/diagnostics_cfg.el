;;; diagnostics_cfg.el --- Quiet Flymake / Eglot diagnostics -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'flymake)

;; Do not run diagnostics continuously while inserting.  We explicitly start
;; checks on save and provide an on-demand command.
(setq flymake-no-changes-timeout 0.3
      flymake-start-on-save-buffer t
      flymake-start-on-flymake-mode t
      flymake-fringe-indicator-position 'right-fringe)

(defun cfg/flymake-start ()
  "Run diagnostics now."
  (interactive)
  (when (derived-mode-p 'prog-mode)
    (flymake-start)))

(defun cfg/flymake-problems ()
  "Display the current buffer's Flymake diagnostics."
  (interactive)
  (if (fboundp 'flymake-show-buffer-diagnostics)
      (flymake-show-buffer-diagnostics)
    (flymake-show-diagnostics-buffer)))

(defun cfg/flymake-hide ()
  "Hide the Flymake diagnostics buffer."
  (interactive)
  (when-let* ((win (get-buffer-window "*Flymake diagnostics*")))
    (delete-window win)))

(defun cfg/flymake-next ()
  "Go to the next diagnostic."
  (interactive)
  (flymake-goto-next-error))

(defun cfg/flymake-prev ()
  "Go to the previous diagnostic."
  (interactive)
  (flymake-goto-prev-error))

(add-hook 'prog-mode-hook #'flymake-mode)

(global-set-key (kbd "C-c C-d") #'consult-flymake)
(global-set-key (kbd "C-c n") #'flymake-goto-next-error)
(global-set-key (kbd "C-c p") #'flymake-goto-prev-error)

(provide 'diagnostics_cfg)
;;; diagnostics_cfg.el ends here
