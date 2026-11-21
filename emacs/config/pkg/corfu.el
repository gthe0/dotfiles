;;; corfu.el --- Corfu completion module -*- lexical-binding: t; -*-
'(corfu)

;; Enable auto completion, configure delay, trigger and quitting
(require 'corfu)
(setq corfu-auto t
      corfu-cycle t
      corfu-preview-current t
      corfu-scroll-margin 5
      corfu-count 10
      corfu-preselect 'first
      corfu-auto-prefix 4
      ;; Tab behaviour
      tab-always-indent 'complete)

(global-corfu-mode 1)
;;; corfu.el ends here
