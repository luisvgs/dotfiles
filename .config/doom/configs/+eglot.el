(use-package! eglot
  :defer t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-to-list 'eglot-server-programs '(tuareg-mode "ocamllsp"))
  (add-to-list 'eglot-server-programs '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
  :hook
  ((rjsx-mode tuareg-mode rust-mode typescript-mode js2-mode scala-mode agda2-mode haskell-mode) . eglot-ensure))

(use-package! agda2-mode :mode (("\\.l?agda\\'" . agda2-mode)
                                ("\\.lagda.md\\'" . agda2-mode)))
(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "brittany"
        haskell-stylish-on-save t
        haskell-mode-stylish-haskell-path "brittany"
        tab-width 2))

(use-package! idris-mode
  :mode ("\\.idr\\'")
  :custom
  (idris-interpreter-path "idris2"))

(use-package! scala-mode
  :mode ("\\.sc\\'" "\\.scala\\'")
  :interpreter ("scala" . scala-mode)
  :init
  (setq scala-indent:step 4)
  (setq-local eglot-workspace-configuration
              '((metals (scalafmt-config-path ("scalafmt.conf")))))
  )

(use-package! sbt-mode
  :defer t
  :commands sbt-start sbt-command
  :config
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  (setq sbt:program-options '("-Dsbt.supershell=false")))
