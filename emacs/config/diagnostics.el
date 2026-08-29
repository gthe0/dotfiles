;;; cfg-diagnostics.el --- Quiet Flymake / Eglot diagnostics -*- lexical-binding: t; -*-

(require 'flymake)

;; Do not run diagnostics continuously while inserting.  We explicitly start
;; checks on save and provide an on-demand command.
(setq flymake-no-changes-timeout nil
      flymake-start-on-flymake-mode t
      flymake-start-on-save-buffer t
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

(global-set-key (kbd "C-c !") #'cfg/flymake-problems)
(global-set-key (kbd "C-c n") #'cfg/flymake-next)
(global-set-key (kbd "C-c p") #'cfg/flymake-prev)
(global-set-key (kbd "C-c C-!") #'cfg/flymake-start)

;; Eglot's diagnostic publishing goes through Flymake.  Keep the normal Eglot
;; transport active, but do not turn changes into immediate diagnostic runs.
(with-eval-after-load 'eglot
  (setq eglot-send-changes-idle-time 1.0))


(provide 'diagnostics)
;;; cfg-diagnostics.el ends here
