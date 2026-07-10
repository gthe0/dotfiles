;;; languages --- Summary
;;; Commentary:
;;; Code:
(editorconfig-mode 1)

;; Eglot Mode
(require 'eglot)

(setq eglot-inlay-hints-mode nil)

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-or-c++-mode-hook 'eglot-ensure)

;; I prefer to have the code unindented inside of namespaces
(c-set-offset 'innamespace 0)

(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq c-default-style "bsd")
(setq c-basic-indent 4)
(setq c-basic-offset 4)

;; flymake
(flymake-mode 1)

;; I do not like the fact that the lsp changes whenever I type something
(with-eval-after-load 'flymake
  ;; Completely disable the idle timer so it never checks while typing
  (setq flymake-no-changes-timeout nil))

(provide 'languages)
;;; langauages.el ends here
