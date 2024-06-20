(use-package! doom-modeline
  :config
  (setq doom-modeline-height 36
        doom-modeline-unicode-fallback nil
        doom-modeline-icon t
        doom-plain-brighter-modeline nil
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'file-name
        doom-modeline-workspace-name t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-name t
        doom-modeline-modal-modern-icon t
        doom-modeline-lsp-icon t
        doom-modeline-lsp t
        doom-modeline-modal-icon nil
        doom-modeline-modal t
        doom-modeline-persp-icon t
        doom-modeline-persp-name nil)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))

(use-package! nyan-mode
  :hook (doom-modeline-mode . nyan-mode))
