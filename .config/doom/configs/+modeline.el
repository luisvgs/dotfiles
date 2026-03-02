(use-package! doom-modeline
  :config
  (setq doom-modeline-height 50
        doom-modeline-major-mode-icon t
        doom-modeline-project-name nil
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
        doom-modeline-enable-word-count nil
        doom-modeline-time-analogue-clock nil
        doom-modeline-time-icon nil
        doom-modeline-hud nil
        doom-modeline-mu4e nil
        doom-modeline-time nil
        doom-modeline-vcs-icon t
        doom-modeline-vcs-max-length 15
        doom-modeline-vcs-display-function #'doom-modeline-vcs-name
        doom-modeline-vcs-state-faces-alist
        '((needs-update . (doom-modeline-warning bold))
          (added        . (doom-modeline-info bold))
          (edited       . (doom-modeline-buffer-modified bold))
          (removed      . (doom-modeline-urgent bold))
          (conflict     . (doom-modeline-urgent bold))
          (unregistered . (doom-modeline-urgent bold)))
        doom-modeline-persp-icon nil
        doom-modeline-modal-modern-icon nil
        doom-modeline-persp-name nil)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange")))
