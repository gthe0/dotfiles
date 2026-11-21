;;; editing_cfg.el --- Editing ergonomics -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defun cfg/move-line-up ()
  "Move current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun cfg/move-line-down ()
  "Move current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun cfg/open-line-below ()
  "Open a line below and indent it."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun cfg/open-line-above ()
  "Open a line above and indent it."
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

;; Move line above or below like in source code buffers
(with-eval-after-load 'prog-mode-hook
  '(define-key prog-mode-map (kbd "M-p") #'cfg/move-line-up)
  '(define-key prog-mode-map (kbd "M-n") #'cfg/move-line-down))

(global-set-key (kbd "C-o") #'cfg/open-line-below)
(global-set-key (kbd "C-M-o") #'cfg/open-line-above)

(provide 'editing_cfg)
;;; editing_cfg.el ends here
