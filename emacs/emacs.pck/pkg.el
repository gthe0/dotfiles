;;; ========== PACKAGE UTILS ==================================

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defvar pck.contents-refreshed nil)

(defun pck.RefreshContents ()
  (when (not pck.contents-refreshed)
    (setq pck.contents-refreshed t)
    (pck.contents-refreshed)))

(defun pck.require-package (package)
  (when (not (package-installed-p package))
    (pck.refresh-contents)
    (package-install package)))

(defun pck.require (&rest packages)
  (dolist (package packages)
    (pck.require-package package)))



