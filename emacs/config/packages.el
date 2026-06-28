;;; ======== Package Manager Settings ========

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
(use-package vscode-dark-plus-theme
  :config (load-theme 'vscode-dark-plus t))

;;; ======== Vertico Mode ========

(use-package vertico
  :init
  (vertico-mode 1)
  :config
  ;; Keep your interface clean and compact (shows 10 results max)
  (setq vertico-count 10))

(use-package orderless
  :init
  ;; Configure orderless as the default completion style
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        ;; This tells Emacs to allow orderless components separated by spaces
        completion-category-overrides '((file (styles basic partial-completion)))))

;; Beautiful metadata columns (gives descriptions next to choices)
(use-package marginalia
  :init
  (marginalia-mode 1))

;; Navigation search utilities (The fast modern alternative to Helm features)
(use-package consult)

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
	(define-key company-active-map (kbd "C-w") #'evil-delete-backward-word)
	(define-key minibuffer-local-map (kbd "C-w") #'evil-delete-backward-word)))

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

;;; ======== Find replacement ========
(use-package find-lisp :ensure nil)

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
  ;; to not type x accidentaly and close the buffer
  (evil-ex-define-cmd "ex" 'evil-edit)
  (evil-define-key 'normal 'global (kbd "gd") 'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "C-w o") 'toggle-delete-other-windows)
  (evil-define-key 'normal 'global (kbd "[d") 'flymake-goto-prev-error)
  (evil-define-key 'normal 'global (kbd "]d") 'flymake-goto-next-error)
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
    "h" '(:ignore t :wk "help")
    "f" '(:ignore t :wk "file")
    "t" '(:ignore t :wk "toggle")
    "b" '(:ignore t :wk "buffer")
    "p" '(:ignore t :wk "project")
	
	;; project specific
	"pf" '(project-find-file :which-key "Fuzzy Find File inside Project")
	"pd" '(project-find-dir :which-key "Fuzzy Find Dir inside Project")
	"pp" '(project-switch-project :which-key "Switch Project Folder")
	"pc" '(project-compile :which-key "Project Compile")
	"p." '(project-dired :which-key "Open Dired in Project Root")

	;; buffer related keys
	"bi" '(ibuffer-other-window :which-key "Interactive Buffer Picker")
	"bb" '(consult-buffer :which-key "Simple Buffer Jump")
	"bo" '(consult-buffer-other-window :which-key "Open Buffer in a new Window using Consult")
	"br" '(rename-buffer :which-key "Rename Buffer")

	;; Note(gtheo): I may change it to fd or find or whatever. Don't know yet.
	"fd" '(consult-fd :which-key "Consult Find File")

	;; files and dired
	"fr" '(consult-recent-file :which-key "Recent files")
	"o" '(dired-jump :which-key "Dired")

	;; grep find
	"."  '(find-file :which-key "Equivalent to :e command")
	"/"  '(grep-find :which-key "Equivalent to grep -rn")

	;; toggle various options
	"td" '(consult-flymake :which-key "Toggle Problem Pane")
	;; Quality of life features
	;; My thumb hurt whenever I tried to acces M-x
	"SPC" '(execute-extended-command :which-key "M-x"))

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
        dashboard-startup-banner 'logo-ansi-256color
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-navigation-cycle t)
  (with-eval-after-load 'evil
    (evil-make-overriding-map dashboard-mode-map 'normal)))

;; ======== Extra Minimal Utilities ========

(use-package yasnippet-snippets)
(use-package yasnippet
  :config
  (yas-global-mode 1))

(provide 'packages)

;;; packages.el ends here
