;;; files.el --- Dired/Dirvish/Wdired -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'dired)
(require 'wdired)

(setq dired-kill-when-opening-new-dired-buffer t
      dired-auto-revert-buffer t
      dired-dwim-target t
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-listing-switches
      (if (eq system-type 'windows-nt)
          "-alh"
        "-alh"))

;; Wdired edits existing names.  We intentionally do not create files from
;; arbitrary edited lines: that is unsafe and unlike Dired's filesystem model.
(setq wdired-allow-to-change-permissions t
      wdired-use-interactive-rename nil)

(defun cfg/dired-writable ()
  "Enter Wdired in the current Dired/Dirvish buffer."
  (interactive)
  (if (derived-mode-p 'dired-mode)
      (wdired-change-to-wdired-mode)
    (user-error "Not a Dired buffer")))

(defun cfg/dired-create-file ()
  "Create a file explicitly in the current directory."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (user-error "Not a Dired buffer"))
  (let ((name (read-string "Create file: ")))
    (when (string-empty-p name)
      (user-error "Empty file name"))
    (let ((file (expand-file-name name default-directory)))
      (if (file-exists-p file)
          (user-error "Already exists: %s" name)
        (make-empty-file file)
        (revert-buffer)
        (find-file file)))))

(defun cfg/dired-create-directory ()
  "Create a directory explicitly in the current Dired buffer."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (user-error "Not a Dired buffer"))
  (let ((name (read-string "Create directory: ")))
    (when (string-empty-p name)
      (user-error "Empty directory name"))
    (make-directory (expand-file-name name default-directory))
    (revert-buffer)))

(define-key dired-mode-map (kbd "C-c C-w") #'cfg/dired-writable)
(define-key dired-mode-map (kbd "+") #'cfg/dired-create-file)
(define-key dired-mode-map (kbd "C-c +") #'cfg/dired-create-file)
(define-key dired-mode-map (kbd "C-c C-d") #'cfg/dired-create-directory)

;; Dirvish uses Dired's editing facilities.  Keep Wdired explicit.
(with-eval-after-load 'dirvish
  (define-key dirvish-mode-map (kbd "C-c C-w") #'cfg/dired-writable)
  (define-key dirvish-mode-map (kbd "+") #'cfg/dired-create-file)
  (define-key dirvish-mode-map (kbd "C-c +") #'cfg/dired-create-file))

(global-set-key (kbd "C-x C-r") #'recentf)

(provide 'files)
;;; files.el ends here
