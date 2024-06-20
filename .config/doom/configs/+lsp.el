(use-package! lsp-mode
  :defer t
  :hook
  (rust-mode . lsp)
  (json-mode . lsp)
  (sh-mode . lsp)
  (scala-mode . lsp)
  (typescript-ts-mode . lsp)
  (haskell-mode . lsp)
  (tsx-mode . lsp)
  (latex-mode . lsp)
  (LaTeX-mode . lsp)
  (tuareg-mode . lsp)
  (js2-mode . lsp)
  (rjsx-mode . lsp)
  :commands lsp-deferred
  :bind (:map lsp-mode-map
              ("C-c d" . lsp-describe-thing-at-point)
              ("C-c g" . lsp-ui-doc-glance))
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (lsp-enable-which-key-integration t)
  (map! :leader
        :prefix "c"
        :desc "Peek references" "p" #'lsp-ui-peek-find-references)
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-server-display-inlay-hints nil
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
        lsp-rust-analyzer-display-chaining-hints nil
        lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
        lsp-rust-analyzer-display-closure-return-type-hints nil
        lsp-rust-analyzer-display-parameter-hints nil
        lsp-rust-analyzer-display-reborrow-hints nil
        lsp-log-io nil
        lsp-eldoc-enable-hover nil
        lsp-eldoc-render-all nil
        lsp-modeline-code-actions-enable t
        ))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-eldoc-enable-hover nil
        lsp-eldoc-render-all nil
        lsp-eldoc-enable-hover nil
        eldoc-documentation-functions nil
        ;; (setq lsp-ui-sideline-enable t)
        ;; (setq lsp-ui-sideline-show-diagnostics t)
        ;; (setq lsp-ui-sideline-show-hover t)
        ;; (setq lsp-ui-peek-always-show nil)
        ;; (setq lsp-ui-doc-enable nil)
        ))
