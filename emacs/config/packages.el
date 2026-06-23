;; ======== Package Manager Settings ========

(require 'package)
;; Add standard package repositories so Emacs knows where to download things
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (message "Refreshing contents...")
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Ensure that everything is installed
(setq use-package-always-ensure t)

;;; ======== Theme ========

(use-package nerd-icons)

(use-package doom-themes
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

;;; ======== Move Text ========

(use-package move-text
  :bind
  ("M-p" . move-text-up)
  ("M-n" . move-text-down))

;;; ======= Mixed Pitch Mode =======

;; Used for having proportional fonts to display text that isn't code
(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))

;;; ======== Company Mode ========

;; The standard dropdown as-you-type menu of modern IDEs

(use-package prescient
  :defer 1
  :config
  (prescient-persist-mode 1))

(use-package company
  :defer 1
  :config
  (global-company-mode 1)
  (with-eval-after-load 'evil
	(define-key company-active-map (kbd "C-w") #'evil-delete-backward-word)))

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

;;; ======== Treemacs ========

(use-package treemacs
  :commands treemacs)

(use-package treemacs-evil
  :after treemacs evil)

;;; ======== Evil Mode  ========						

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-respect-visual-line-mode t)
  :config
  ;; Wanted to have Ex
  (evil-set-undo-system 'undo-redo)
  (evil-ex-define-cmd "Ex" 'dired-jump)
  (evil-define-key 'normal 'global (kbd "gd") 'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "C-w o") 'toggle-delete-other-windows)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  (with-eval-after-load 'dired
	(evil-collection-define-key 'normal
	  'dired-mode-map "c" #'dired-create-empty-file)))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

;; Vim-style multiple cursors (Alt+D to mark next match)
(use-package evil-multiedit
  :after evil
  :config
  (evil-multiedit-default-keybinds))

;; general

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
    "h" '(:ignore t :wk "help")
    "t" '(:ignore t :wk "toggle")
    "b" '(:ignore t :wk "buffer")
    "p" '(:ignore t :wk "project")
	
	;; project specific
    "pf" '(project-find-file :which-key "Fuzzy Find File inside Project")
	"ps" '(consult-grep :which-key "Project-wide grep-ing")  
	"/"  '(consult-grep :which-key "Project-wide grep-ing")  
	"pc" '(project-compile :which-key "Compile the project")  

	;; buffer related keys
    "bi" '(ibuffer :which-key "Interactive Buffer Picker")
    "bb" '(consult-buffer :which-key "Consult Interactive Buffer Picker ")
    "bk" '(kill-this-buffer  :which-key "Kill Current Buffer")
    "bn" '(next-buffer :which-key "Go to next Buffer")
    "bp" '(previous-buffer :which-key "Go to previous Buffer")

	;; files and dired
    "fr"  '(consult-recent-file :which-key "Recent files")
	"."  '(find-file :which-key "Find File")
	
	;; grep find
	"rg" '(grep-find :which-key "Equivalent to grep -rn")

	;; toggle various options
	"tp" '(consult-flymake :which-key "Toggle Problem Pane")
	"fd" '(consult-flymake :which-key "Toggle Problem Pane")
	"tt" '(treemacs :which-key "Toggle Treemacs")

	;; qol features
	":" '(execute-extended-command :which-key "M-x palette")

	;; help
	"hk"  '(describe-key :which-key "Help for key binding")
	"hf"  '(describe-function :which-key "Help for function")
	"hv"  '(describe-variable :which-key "Help for variable"))

	(general-mmap
	  :prefix "\\"
	  "" '(:ignore t :wk "mode")))

;; ======== Aesthetics ========

;; dashboard for projects
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5) (projects . 5))
        dashboard-banner-logo-title "Select Project"
        dashboard-startup-banner 'official
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-navigation-cycle t)
  (with-eval-after-load 'evil
    (evil-make-overriding-map dashboard-mode-map 'normal)))

;; ======== Extra Minimal Utilities ========

(use-package yasnippet-snippets)
(use-package yasnippet
  :config (yas-global-mode 1))

(provide 'packages)
