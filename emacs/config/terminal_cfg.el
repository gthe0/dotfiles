;;; terminal_cfg.el --- Eshell and Windows command helpers -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'compile)

;; Emacs's compile-mode is the primary command runner for this configuration.
;; On Windows this works with cmd.exe and therefore does not require grep/find.
(setq compilation-scroll-output 'first-error
      compilation-always-kill t
      compilation-ask-about-save nil)

(defun cfg/compile-search-findstr ()
  "Run a Windows FINDSTR search through compile-mode.
The default searches the current directory recursively."
  (interactive)
  (let ((query (read-string "findstr search: ")))
    (when (string-empty-p query)
      (user-error "Empty search string"))
    (compile
     (format "findstr /SNIR \"%s\" *.*"
             (replace-regexp-in-string "\"" "\"\"" query)))))

(defun cfg/compile-custom-command ()
  "Prompt for any command and run it through compile-mode."
  (interactive)
  (let ((command (read-shell-command
                  "Compile/run command: "
                  (or compile-command ""))))
    (setq compile-command command)
    (compile command)))

(global-set-key (kbd "C-c s") #'cfg/compile-search-findstr)
(global-set-key (kbd "C-c C-c") #'cfg/compile-custom-command)

;; Eshell is available as the native terminal alternative.
(global-set-key (kbd "C-c t") #'eshell)

;; In Eshell, `q` should not unexpectedly kill Emacs; use C-c C-q to leave.
(with-eval-after-load 'eshell
  (add-hook 'eshell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-q") #'eshell/exit))))

(provide 'terminal_cfg)
;;; terminal_cfg.el ends here
