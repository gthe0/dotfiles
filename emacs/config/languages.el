;; Editor Config
(editorconfig-mode 1)

;; Eglot Mode
(require 'eglot)

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-or-c++-mode-hook 'eglot-ensure)

(setq c-default-style "bsd")
(setq c-basic-indent 4)
(setq c-basic-offset 4)

;; Cmake mode 
(use-package cmake-mode
  :ensure true)

;; I prefer to have the code unindented inside of namespaces
(c-set-offset 'innamespace 0)

(provide 'languages)
