;; Change the grep-find with findstr in windows 
(when (eq system-type 'windows-nt)
  (with-eval-after-load 'grep
	(setq grep-save-buffers 'save)
	(grep-apply-setting 'grep-find-command
						'("findstr /S /N /I /R \"\" *.*" . 22))))

(provide 'platform)
