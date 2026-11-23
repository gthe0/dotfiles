;;; multiple_cursors.el --- Multiple cursors setup -*- lexical-binding: t; -*-
'(multiple-cursors)

(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)

;;; multiple_cursors.el ends here
