(use-package! doom-modeline
  :config
  (setq doom-modeline-height 32
        doom-modeline-unicode-fallback t
        doom-modeline-icon t
        doom-plain-brighter-modeline t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-with-project
        doom-modeline-workspace-name t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-name t
        doom-modeline-modal t
        doom-modeline-modal-modern-icon t
        doom-modeline-modal-icon t
        doom-modeline-lsp-icon t
        doom-modeline-lsp nil
        doom-modeline-modal nil
        doom-modeline-persp-name nil)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))

(use-package! nyan-mode
  ;; :after doom-modeline
  :hook (doom-modeline-mode . nyan-mode))
;; :config (nyan-mode t))
