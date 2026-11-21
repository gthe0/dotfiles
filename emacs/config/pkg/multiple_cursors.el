;;; multiple_cursors.el --- Multiple cursors setup -*- lexical-binding: t; -*-
'(multiple-cursors)

(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m l") 'mc/edit-lines)

;;; multiple_cursors.el ends here
