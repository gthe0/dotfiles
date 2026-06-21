;; ======== Package Manager Settings ========

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("ublt" . "https://elpa.ubolonton.org/packages/") t)

(setq package-native-compile t)
(setq use-package-always-ensure t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (message "refreshing contents")
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;; ======== Helm Mode ========

(use-package helm
  :init
  (helm-mode 1) ; Activates Helm globally for standard Emacs commands
  :config
  (setq helm-mode-fuzz-matching t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t)
  :bind
  (("M-x" . helm-M-x)
   ("C-x b" . helm-mini)       ; Quick buffer & recent files menu
   ("C-s" . helm-occur)        ; Live search inside the active file
   ("M-y" . helm-show-kill-ring) ; Interactive clipboard history
   ("C-c i" . helm-imenu)))    ; Open interactive code map (functions list)


;;; ======== Meow Modal Editing ========

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  
  ;; Motion mode overrides (navigating menus/lists like Helm)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  
  ;; Leader bindings (Tapping Space in Normal Mode)
  (meow-leader-define-key
   '("j" . meow-next-expand)
   '("k" . meow-prev-expand)
   '("?" . meow-cheatsheet)

   '("b" . helm-mini)               ; Space b to switch buffers
   '("p f" . helm-find-files))      ; Space p f to open files list
  
  ;; Normal Mode Core Bindings
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("r" . meow-replace)
   '("R" . meow-swap)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . meow-last-buffer)))

(use-package meow
  :init
  (meow-setup)
  (meow-global-mode 1))

(provide 'package)
