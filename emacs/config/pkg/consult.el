;;; consult.el --- Consult search and navigation module -*- lexical-binding: t; -*-

'(consult)

(use-package consult
  :bind (
         ;; C-x bindings (ctl-x-map)
         ("C-x b"   . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x r b" . consult-bookmark)
         ("C-x C-b" . ibuffer)

         ;; Search / Grep bindings (M-s)
         ("M-s r"   . consult-ripgrep)
         ("M-s m"   . consult-mark)

         ;; Goto / Structure bindings (M-g)
         ("M-g i"   . consult-imenu)
         ("M-g I"   . consult-imenu-multi)
         ("M-g e"   . consult-compile-error)

         ;; Kill ring history replacement
         ("M-y"     . consult-yank-pop))

  :init
  ;; Tweak register preview behavior for clean visuals
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  (advice-add #'register-preview :override #'consult-window-preview))

;;; consult.el ends here 
