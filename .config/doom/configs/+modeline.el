(use-package! doom-modeline
  :config
  (setq doom-modeline-height 30
        doom-modeline-battery t
        doom-themes-padded-modeline t
        doom-flatwhite-brighter-modeline nil
        doom-modeline-unicode-fallback t
        doom-modeline-icon t
        doom-plain-brighter-modeline nil
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-except-project
        doom-modeline-workspace-name t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-name t
        doom-modeline-modal t
        doom-modeline-modal-modern-icon nil
        doom-modeline-modal-icon t
        doom-modeline-lsp-icon t
        doom-modeline-persp-name t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
