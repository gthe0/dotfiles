;;; cape.el --- CAPE module -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

'(cape)

(require 'cape)

(add-hook 'completion-at-point-functions #'cape-dabbrev)
(add-hook 'completion-at-point-functions #'cape-file)

;;; cape.el ends here
