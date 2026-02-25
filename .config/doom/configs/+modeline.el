(use-package! doom-modeline
  :config
  (setq doom-modeline-height 50
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'auto
        doom-modeline-workspace-name nil
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-name t
        doom-modeline-modal-modern-icon t
        doom-modeline-lsp-icon t
        doom-modeline-lsp t
        doom-modeline-modal-icon t
        doom-modeline-modal t
        doom-modeline-mu4e t
        doom-modeline-persp-icon t
        doom-modeline-persp-name t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
