;;; ======== General Configuration ========

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tooltip-mode -1))

;;; ======== Visuals & Editor Tweaks ========

;; Display relative line numbers
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)
(global-display-line-numbers-mode 1)

(column-number-mode 1)
(show-paren-mode 1)

;; General Settings
(setq-default inhibit-splash-screen t
			  make-backup-files nil
			  create-lockfiles nil
			  tab-width 4
			  compilation-scroll-output t
			  delete-selection-mode t
			  use-short-answers t
			  dired-kill-when-opening-new-dired-buffer t
			  visible-bell (or (equal system-type 'windows-nt)
							   (and (equal system-type 'gnu/linux)
									(getenv "WSLENV"))))

(setq set-mark-command-repeat-pop t)
	
;; Bidirectional text scanning
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Skip fontification during input
(setq redisplay-skip-fontification-on-input t)

;; default read-process-output-max is too small (64 KB)
;; for modern features such as LSPs (Even if we do not use them)
;; Make it 4 MB instead
(setq read-process-output-max (* 4 1024 1024)) ; 4MB

;; Do not render the cursor in non selected windows
;; (less practical but looks nice)
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; Save the existing clipboard into the kill ring to not overwrite
;; clipboard-yank
(setq save-interprogram-paste-before-kill t)

;; Clip rings should not save duplicates
(setq kill-do-not-save-duplicates t)

;; No need to chmod +x for scripts
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; No need to fing file if it looks like a host name
(setq ffap-machine-p-known 'reject)

;; reduce GB from emacs

(defvar cfg/gc-cons-threshold 16777216)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold cfg/gc-cons-threshold
                  gc-cons-percentage 0.1)))

(defun cfg/defer-garbage-collection-h ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun cfg/restore-garbage-collection-h ()
  ;; Defer it so that commands launched immediately after will enjoy the
  ;; benefits.
  (run-at-time
   1 nil (lambda () (setq gc-cons-threshold cfg/gc-cons-threshold))))

(add-hook 'minibuffer-setup-hook #'cfg/defer-garbage-collection-h)
(add-hook 'minibuffer-exit-hook #'cfg/restore-garbage-collection-h)
(setq garbage-collection-messages t)

;; compilation mode


;; When I use compilation mode, I would like it to switch windows automatically
(defun pck/switch-to-grep-window (buffer status)							
  (let ((win (get-buffer-window buffer)))									
    (when win																
      (select-window win))))												
																			
(add-hook 'compilation-finish-functions #'pck/switch-to-grep-window)		

;; dired

(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")

;; Set UTF-8 by default 
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;; Ultimate Windows hacks
(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode
           (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)

(setq window-combination-resize t
	  help-window-select t)

;; Pair
(require 'elec-pair)
(electric-pair-mode 1)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; Editor Config
(editorconfig-mode 1)

;; To see if it loaded properly
(provide 'config)
