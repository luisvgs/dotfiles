(use-package! lsp-mode
  :hook
  (rustic-mode . lsp)
  (json-mode . lsp)
  (sh-mode . lsp)
  (typescript-mode . lsp)
  (latex-mode . lsp)
  (LaTeX-mode . lsp)
  (javascript-mode . lsp)
  (rjsx-mode . lsp)
  (rust-mode . lsp)
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all nil)
  (lsp-inlay-hint-enable nil)
  (lsp-lens-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-rust-analyzer-server-display-inlay-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints nil)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (setq eldoc-documentation-functions nil))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable nil))
