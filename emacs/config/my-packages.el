;; ======== Package Manager Settings ========

(require 'package)
(package-initialize)

(unless (package-installed-p 'use-package)
  (message "refreshing contents")
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;; ======== Theme ========

(use-package nerd-icons)
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-one") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;;; ======== Vertico Mode ========

(use-package vertico
  :init
  (vertico-mode 1)
  :config
  ;; Keep your interface clean and compact (shows 10 results max)
  (setq vertico-count 10))

;; Smart fuzzy searching (type "pckg" to match "package.el")
(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

;; Beautiful metadata columns (gives descriptions next to choices)
(use-package marginalia
  :init
  (marginalia-mode 1))

;; Navigation search utilities (The fast modern alternative to Helm features)
(use-package consult)

;;; ======== Ido Mode ========

(use-package smex)
(use-package ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1) 
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; ======== Move Text ========

(use-package move-text
  :bind
  ("M-p" . move-text-up)
  ("M-n" . move-text-down))

;;; ======= Mixed Pitch Mode =======

;; Used for having proportional fonts
;; to display text that isn't code

(use-package mixed-pitch
  :after all-the-icons
  :defer 1
  :commands mixed-pitch-mode
  :custom
  (mixed-pitch-set-height t))

;;; ======== Company Mode ========

;; The standard dropdown as-you-type menu of modern IDEs

(use-package prescient
  :defer 1
  :config
  (prescient-persist-mode 1))

(use-package company
  :defer 1
  :config
  (global-company-mode 1))

(use-package company-prescient
  :defer 1
  :after company prescient
  :config
  (company-prescient-mode 1))

(use-package company-posframe
  :defer 1
  :after company
  :custom
  (company-posframe-quickhelp-delay nil)
  :config
  (company-posframe-mode 1))

;;; ======== Projectile ========

(use-package projectile
  :ensure t
  :demand t
  :init
  (projectile-mode +1)
  :config
  ;; This ensures projectile plays nice with Vertico cache
  (setq projectile-indexing-method 'hybrid))

;;; ======== Evil Mode  ========

(use-package undo-tree
  :demand t
  :config
  (global-undo-tree-mode))
(use-package evil
  :demand t
  :after undo-tree
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-tree)
  :config
  (evil-mode 1))
(use-package evil-collection
  :demand t
  :after evil
  :config
  (evil-collection-init))
(use-package evil-commentary
  :demand t
  :after evil
  :config
  (evil-commentary-mode 1))
(use-package evil-surround
  :demand t
  :after evil
  :config
  (global-evil-surround-mode 1))

;;; ======== General Mode  ========

;; Add the hook to the compilation/grep finish alert sequence
(add-hook 'compilation-finish-functions #'my/switch-to-grep-window)
(use-package general
  :demand t
  :config
  (general-evil-setup t)
  (general-create-definer leader-def
    :states '(normal motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC")
  (leader-def
    "" '(:ignore t :wk "leader")
    "f" '(:ignore t :wk "file")
    "c" '(:ignore t :wk "checks")
    "t" '(:ignore t :wk "toggle")
    "b" '(:ignore t :wk "buffer")
    "p" '(:ignore t :wk "project")
    "pf" 'projectile-find-file
	"d"  'dired-jump
    "bi" 'ibuffer
    "bd" 'kill-this-buffer
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "bx" 'kill-buffer-and-window
	"rg" 'grep-find)

  (general-create-definer localleader-def
    :states '(normal motion emacs)
    :keymaps 'override
    :prefix "\\"
    :non-normal-prefix "C-SPC m")
  (localleader-def "" '(:ignore t :wk "mode")))

;; Wanted to have Ex
(evil-ex-define-cmd "Ex" 'dired-jump)


;; I am not sure how well it will integrate 
;; with the rest of the config, we ll see

;;; Treemacs

(use-package treemacs
  :defer 2
  :commands treemacs treemacs-find-file
  :general
  (leader-def
    "tt" 'treemacs
    "tf" 'treemacs-find-file))
(use-package treemacs-evil
  :defer 1
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile
  :demand t
  :general
  (leader-def
	"pd" 'treemacs-projectile)) 

(provide 'my-packages)
