(use-package! eglot
  :defer t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:hoverProvider :documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (add-to-list 'eglot-server-programs '(rustic-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  :hook
  ((rjsx-mode rustic-mode typescript-mode js2-mode scala-mode) . eglot-ensure))

(use-package! scala-mode :mode ("\\.sc\\'" "\\.scala\\'"))
