(use-package! eglot
  :defer t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:hoverProvider :documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1)))
  :hook
  ((rjsx-mode rust-mode typescript-mode js2-mode scala-mode) . eglot-ensure))

(use-package! scala-mode :mode ("\\.sc\\'" "\\.scala\\'"))
