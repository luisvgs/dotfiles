;; -*- lexical-binding: t -*-
;; TODO figure out how to lazy load lean4-mode
(use-package! eglot
  :defer t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  ;; (setq-default eglot-workspace-configuration
  ;;               '((haskell
  ;;                  (plugin
  ;;                   (stan
  ;;                    (globalOn . :json-false))))))
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-to-list 'eglot-server-programs '(tuareg-mode "ocamllsp"))
  ;; (add-to-list 'eglot-server-programs '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
  :hook
  ((rjsx-mode tuareg-mode rust-mode typescript-mode js2-mode scala-mode) . eglot-ensure))



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
