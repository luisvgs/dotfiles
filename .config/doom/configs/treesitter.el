(use-package! tree-sitter
  ;; :after lsp-mode
  :after eglot
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
