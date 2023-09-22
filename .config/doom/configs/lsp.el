(use-package! lsp-mode
  :hook
  (rustic-mode . lsp)
  (json-mode . lsp)
  (sh-mode . lsp)
  (scala-mode . lsp)
  (typescript-mode . lsp)
  (latex-mode . lsp)
  (LaTeX-mode . lsp)
  (javascript-mode . lsp)
  (js2-mode . lsp)
  (rjsx-mode . lsp)
  (rust-mode . lsp)
  :commands lsp
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-eldoc-render-all nil)
  (setq lsp-inlay-hint-enable nil)
  (setq lsp-lens-enable nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-rust-analyzer-server-display-inlay-hints nil)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-chaining-hints nil)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (setq lsp-rust-analyzer-display-closure-return-type-hints nil)
  (setq lsp-rust-analyzer-display-parameter-hints nil)
  (setq lsp-rust-analyzer-display-reborrow-hints nil))

(after! lsp-ui
  :hook lsp-mode
  :config
  (setq lsp-eldoc-enable-hover nil)
  (setq eldoc-documentation-functions nil)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-diagnostics nil)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-peek-always-show nil)
  (setq lsp-eldoc-render-all nil)
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-ui-doc-enable nil)
  )
