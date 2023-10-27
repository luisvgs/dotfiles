(after! doom-modeline
  :config
  (setq doom-modeline-height 32
        doom-modeline-time nil
        doom-modeline-battery t
        doom-themes-padded-modeline t
        doom-flatwhite-brighter-modeline nil
        doom-plain-brighter-modeline nil
        doom-modeline-workspace-name t
        doom-modeline-persp-name t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
