(after! doom-modeline
  :config
  (setq doom-modeline-height 28)
  (setq doom-modeline-time nil)
  (setq doom-modeline-workspace-name t)
  (setq doom-modeline-persp-name t)
  ;; (setq doom-modeline-icon t)
  ;; (setq doom-modeline-major-mode-color-icon t)

  ;; (setq doom-modeline-modal t)
  ;; (setq doom-modeline-modal-icon t)
  ;; (setq doom-modeline-modal-modern-icon t)

  ;; (setq doom-modeline-buffer-state-icon t)
  (custom-set-faces!
    '(doom-modeline-buffer-modified :foreground "orange"))
  )
