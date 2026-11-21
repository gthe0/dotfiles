;;; windows_cfg.el --- Predictable auxiliary windows -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Auxiliary buffers should not randomly steal the source window.
(setq display-buffer-alist
      '(("\\*\\(Warnings\\|Compile-Log\\|Flymake diagnostics\\|grep\\|Occur\\)\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . bottom)
         (slot . 0)
         (window-height . 0.25))
        ("\\*\\(compilation\\|Async Shell Command\\)\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . bottom)
         (slot . 1)
         (window-height . 0.25))
        ("\\*\\(EGLOT\\|eldoc\\).*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . bottom)
         (slot . 2)
         (window-height . 0.20))
        ("\\*eshell\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . bottom)
         (slot . 3)
         (window-height . 0.30))
        ("\\*Help\\*"
         (display-buffer-reuse-window display-buffer-pop-up-window)
         (inhibit-same-window . t)
         (window-height . 0.35))
        ("\\*Messages\\*"
         (display-buffer-reuse-window display-buffer-in-side-window)
         (side . bottom)
         (slot . 4)
         (window-height . 0.20))))

(defun cfg/quit-auxiliary-window ()
  "Quit the current buffer/window like a transient panel."
  (interactive)
  (quit-window t))

(global-set-key (kbd "C-c w q") #'cfg/quit-auxiliary-window)

;; Winner mode
(winner-mode t)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

;; Ultimate Window Management Hack
(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)

;; Keep source buffers focused when launching common auxiliary commands.
(defun cfg/compilation-no-select ()
  "Compile without selecting the compilation window."
  (interactive)
  (let ((compilation-scroll-output 'first-error))
    (call-interactively #'compile)))

(global-set-key (kbd "C-c c") #'cfg/compilation-no-select)

(provide 'windows_cfg)
;;; windows_cfg.el ends here
