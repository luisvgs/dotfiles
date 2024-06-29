(use-package! doom-modeline
  :config
  (setq doom-modeline-height 35
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
        doom-modeline-mu4e t
        doom-modeline-persp-icon nil
        doom-modeline-persp-name nil)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
;; also enable the start of mu4e-alert
(mu4e-alert-enable-mode-line-display)
(use-package! nyan-mode
  :hook (doom-modeline-mode . nyan-mode))
