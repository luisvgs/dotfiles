(use-package! eglot
  :config
  (add-to-list 'eglot-server-programs '(rustic-mode "rust-analyzer"))
  (add-to-list 'eglot-ignored-server-capabilities '(:hoverProvider :documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  :hook
  ((rjsx-mode rustic-mode typescript-mode js2-mode) . eglot-ensure))
