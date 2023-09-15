(after! doom-modeline
  :config
  (setq doom-modeline-height 28)
  (setq doom-modeline-time nil)
  (setq doom-modeline-workspace-name t)
  (setq doom-modeline-persp-name t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange"))
  )
