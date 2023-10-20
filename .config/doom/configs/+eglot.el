(use-package! eglot
  :defer t
  :config
  (setq eglot-ignored-server-capabilities '(:hoverProvider :documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (add-to-list 'eglot-server-programs '(rustic-mode "rust-analyzer"))
  :hook
  ((rjsx-mode rustic-mode typescript-mode js2-mode scala-mode) . eglot-ensure))
