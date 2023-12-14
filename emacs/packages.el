;;; ========== PACKAGE SETTINGS =================

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ido-completing-read+
(use-package ido-completing-read+
  :straight t
  :config
  (require 'ido-completing-read+)
  (ido-ubiquitous-mode t))

;; smex-mode
(use-package smex
 :straight t
 :bind ("M-x" . smex))

;; magit
(use-package cl-lib
  :straight t)

(use-package magit
  :straight t
  :bind ("C-c m s" . magit-status)
  ("C-c m l" . magit-log))

;; Move-text
(use-package move-text
  :straight t
  :bind (("M-n" . move-text-down)
	 ("M-p" . move-text-up))
  :config (move-text-default-bindings))

;; yasnipet

(use-package yasnippet-snippets
  :straight t
 )
(use-package yasnippet
  :straight t
  :config
  (yas-global-mode 1))

;; markdown-mode
(use-package markdown-mode
  :straight t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))
