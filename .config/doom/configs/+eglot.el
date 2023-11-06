;; TODO figure out how to lazy load lean4-mode
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

(use-package! scala-mode
  :mode ("\\.sc\\'" "\\.scala\\'")
  :interpreter ("scala" . scala-mode))

(use-package! sbt-mode
  :commands sbt-start sbt-command
  :config
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  (setq sbt:program-options '("-Dsbt.supershell=false")))
