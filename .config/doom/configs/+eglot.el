(use-package! eglot
  :defer t
  :disabled t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (electric-pair-mode)
  (add-to-list 'eglot-server-programs '(rust-mode "rust-analyzer"))
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-to-list 'eglot-server-programs '(rjsx-mode .("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tuareg-mode "ocamllsp"))
  (add-to-list 'eglot-server-programs '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-to-list 'eglot-server-programs '(tsx-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(typescript-ts-mode . ("typescript-language-server" "--stdio")))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
  :hook
  ((rjsx-mode tuareg-mode rust-mode tsx-ts-mode typescript-ts-mode js2-mode scala-mode agda2-mode haskell-mode idris-mode) . eglot-ensure))

(use-package! flycheck
  :config (flycheck-set-indication-mode 'left-fringe))

(use-package! eglot-booster
  :after eglot
  :disabled t
  :config (eglot-booster-mode))

(use-package! scala-repl :after scala-mode)

(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package! typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)
         ("\\.jsx\\'" . typescript-ts-mode)
         )
  :config
  (setq typescript-ts-mode-indent-offset 4)
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))

(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
          (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))


(use-package! agda2-mode :mode (("\\.l?agda\\'" . agda2-mode)
                                ("\\.lagda.md\\'" . agda2-mode)))
(use-package! haskell-mode
  :config (setq lsp-haskell-formatting-provider "fourmolu"
                haskell-interactive-popup-errors nil
                haskell-stylish-on-save t
                ;; haskell-mode-stylish-haskell-path "fourmolu"
                ;; haskell-mode-stylish-haskell-args  '("-m" "inplace")
                haskell-indentation-layout-offset  4
                haskell-indentation-starter-offset  4
                haskell-indentation-left-offset  4
                haskell-indentation-where-pre-offset  4
                haskell-indentation-where-post-offset  4))

;; (use-package! apheleia
;;   :hook ((prog-mode . apheleia-mode))
;;   :config
;;   (setf (alist-get 'fourmolu apheleia-formatters) '("fourmolu" file))
;;   (add-to-list 'apheleia-mode-alist '(haskell-mode . fourmolu)))

(use-package! idris-mode
  :mode ("\\.idr\\'")
  :custom
  (idris-interpreter-path "idris2"))

(use-package! scala-mode
  :mode ("\\.sc\\'" "\\.scala\\'")
  :interpreter ("scala" . scala-mode)
  :config
  (setq scala-indent:step 2
        scala-indent:indent-value-expression t
        scala-indent:align-parameters t
        scala-indent:align-forms t
        scala-indent:default-run-on-strategy scala-indent:reluctant-strategy)
  (setq-local eglot-workspace-configuration
              '((metals (scalafmt-config-path ("scalafmt.conf")))))
  )

;; Utility
(defun k/scala-toggle-indent:step (arg)
  "Toggle Scala indent step. When ARG is defined, set it as a step value."
  (interactive "P")
  (if arg
      (setq scala-indent:step arg)
    (if (equal scala-indent:step 2)
        (setq scala-indent:step 4)
      (setq scala-indent:step 2)))
  (message (format "set scala-indent:step %s"
                   (propertize (number-to-string scala-indent:step)
                               'face 'font-lock-keyword-face))))

(after! scala-mode
  (setq-hook! 'scala-mode-hook
    comment-line-break-function #'+scala-comment-indent-new-line-fn)
  (set-formatter! 'scalafmt '("scalafmt" "--stdin") :modes '(scala-mode)))

(use-package! sbt-mode
  :defer t
  :commands sbt-start sbt-command
  :config
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
  (setq sbt:program-options '("-Dsbt.supershell=false")))
