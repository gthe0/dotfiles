;;; vertico.el --- Vertico completion module -*- lexical-binding: t; -*-

'(vertico orderless marginalia)

(require 'vertico)
(vertico-mode 1)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides
      '((file (styles orderless partial-completion))
        (command (styles orderless basic))
        (symbol (styles orderless basic))
        (variable (styles orderless basic))
        (function (styles orderless basic))))

(require 'marginalia)
(marginalia-mode 1)

;;; vertico.el ends here
