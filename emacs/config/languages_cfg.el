;;; languages_cfg.el --- Tree-sitter and Eglot -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'treesit)
(require 'eglot)

;; Native Emacs 31 Tree-sitter modes.  Each entry is conditional so a missing
;; grammar or mode never prevents Emacs from starting.
(dolist (entry
         '((c-mode . c-ts-mode)
           (c++-mode . c++-ts-mode)
           (java-mode . java-ts-mode)
           (python-mode . python-ts-mode)
           (js-mode . js-ts-mode)
           (js-json-mode . json-ts-mode)
           (json-mode . json-ts-mode)
           (css-mode . css-ts-mode)
           (html-mode . html-ts-mode)
           (sh-mode . bash-ts-mode)))
  (let ((old (car entry))
        (new (cdr entry)))
    (when (and (fboundp new)
               (boundp (intern (format "%s-hook" old))))
      (add-to-list 'major-mode-remap-alist (cons old new)))))

;; Eglot lsp configuration
(setq eglot-code-action-indications nil
      eglot-report-progress nil
      eglot-max-file-watches 2500)

;; Eglot disabled capabilities
(with-eval-after-load 'eglot
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentOnTypeFormattingProvider))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentHighlightProvider))

;; Eglot is opt-in per programming buffer.  It starts when the language
;; server is available and a project is recognized.
(defun cfg/eglot-ensure ()
  "Start Eglot in the current programming buffer when appropriate."
  (when (and (derived-mode-p 'prog-mode)
             (not (derived-mode-p 'emacs-lisp-mode)))
    (condition-case err
        (eglot-ensure)
      (error
       (message "Eglot not started: %s" (error-message-string err))))))

(add-hook 'prog-mode-hook #'cfg/eglot-ensure)

;; Server programs.  Eglot's defaults cover many languages; these entries
(add-to-list 'eglot-server-programs
             '((c-mode c-ts-mode c++-mode c++-ts-mode) . ("clangd"))
             '((java-mode java-ts-mode)               . ("jdtls")))

;; C/C++ indentation
(setq c-default-style "bsd"
      c-basic-offset 8)

;; Do not enable format-on-save globally. Formatting is explicit via C-c f.
(defun cfg/format-buffer ()
  "Format the current buffer using Eglot or Apheleia when available."
  (interactive)
  (cond
   ((and (fboundp 'eglot-format-buffer)
         (eglot-managed-p))
    (eglot-format-buffer))
   (t
    (user-error "No formatter available for this buffer"))))

;; Keybinds
(global-set-key (kbd "C-c f") #'cfg/format-buffer)
(global-set-key (kbd "C-c r") #'eglot-rename)

(global-set-key (kbd "C-c e r") #'eglot-reconnect)
(global-set-key (kbd "C-c e q") #'eglot-shutdown)

(provide 'languages_cfg)
;;; languages_cfg.el ends here
