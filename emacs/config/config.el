;;; ======== General Configuration ========

(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(column-number-mode 1)
(show-paren-mode 1)

;; General Settings
(setq-default inhibit-splash-screen t
	      make-backup-files nil
	      tab-width 4
	      compilation-scroll-output t
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

(setq window-combination-resize t)
(setq help-window-select t)

;; To see if it loaded properly
(provide 'config)

