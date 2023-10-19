(after! doom-modeline
  :config
  (setq doom-modeline-height 22
        doom-modeline-time nil
        doom-modeline-battery t
        doom-modeline-workspace-name t
        doom-modeline-persp-name t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
