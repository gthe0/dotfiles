;;; cfg-editing.el --- Editing ergonomics -*- lexical-binding: t; -*-

(defun cfg/duplicate-line-or-region ()
  "Duplicate the current line or active region."
  (interactive)
  (let* ((beg (if (use-region-p) (region-beginning) (line-beginning-position)))
         (end (if (use-region-p) (region-end) (line-end-position)))
         (text (buffer-substring beg end)))
    (goto-char end)
    (if (use-region-p)
        (progn
          (newline)
          (insert text)
          (set-mark (point))
          (goto-char (+ end 1)))
      (end-of-line)
      (newline)
      (insert text))))

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

(global-set-key (kbd "C-c d") #'cfg/duplicate-line-or-region)
(global-set-key (kbd "M-p") #'cfg/move-line-up)
(global-set-key (kbd "M-n") #'cfg/move-line-down)
(global-set-key (kbd "C-o") #'cfg/open-line-below)
(global-set-key (kbd "C-S-o") #'cfg/open-line-above)

;; More comfortable window navigation.  These are deliberately simple and
;; work with both Ctrl and right-Alt combinations when Windows sends them.
(global-set-key (kbd "C-c w h") #'windmove-left)
(global-set-key (kbd "C-c w j") #'windmove-down)
(global-set-key (kbd "C-c w k") #'windmove-up)
(global-set-key (kbd "C-c w l") #'windmove-right)

;; Indent the active region, otherwise the current line.
(global-set-key (kbd "C-c i")
                (lambda ()
                  (interactive)
                  (if (use-region-p)
                      (indent-region (region-beginning) (region-end))
                    (indent-according-to-mode))))

;; Recenter without moving point.
(global-set-key (kbd "C-c z") #'recenter-top-bottom)

(provide 'editing)
;;; cfg-editing.el ends here
