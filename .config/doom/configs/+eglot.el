(use-package! eglot
  :defer t
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (electric-pair-mode)
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-to-list 'eglot-server-programs '(rjsx-mode .("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tuareg-mode "ocamllsp"))
  (add-to-list 'eglot-server-programs '(lean4-mode . ("lake" "serve")))
  (add-to-list 'eglot-server-programs '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-to-list 'eglot-server-programs '(tsx-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(typescript-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               `(rust-mode . ("rust-analyzer" :initializationOptions
                              ( :procMacro (:enable t)
                                           :cargo ( :buildScripts (:enable t)
                                                                  :features "all")))))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
  :hook
  ((rjsx-mode tuareg-mode lean4-mode rust-mode tsx-ts-mode typescript-ts-mode js2-mode scala-mode agda2-mode haskell-mode idris-mode) . eglot-ensure))

(use-package! flycheck
  :custom
  (flymake-show-diagnostics-at-end-of-line t)
  :bind (:map global-map
              ("M-n" . #'flymake-goto-next-error)
              ("M-p" . #'flymake-goto-prev-error))
  :config (flycheck-set-indication-mode 'left-fringe))

(use-package! ng2-mode
  :after typescript-mode
  :hook (ng2-html-mode . web-mode)
  :config
  (with-eval-after-load 'typescript-mode (add-hook 'typescript-mode-hook #'lsp))
  ;; (add-to-list 'lsp-disabled-clients 'deno-ls)
  (setq lsp-clients-angular-language-server-command
        '("node"
          "~/.nvm/versions/node/v20.11.0/lib/node_modules/@angular/language-server"
          "--ngProbeLocations"
          "~/.nvm/versions/node/v20.11.0/lib/node_modules"
          "--tsProbeLocations"
          "~/.nvm/versions/node/v20.11.0/lib/node_modules"
          "--stdio"))
  )

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


(setq treesit-font-lock-level 4)

(use-package! typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)
         ("\\.jsx\\'" . typescript-ts-mode)
         )
  :config
  (setq typescript-ts-mode-indent-offset 4)
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))


(use-package! treesit
      :mode (("\\.tsx\\'" . tsx-ts-mode)
             ("\\.js\\'"  . typescript-ts-mode)
             ("\\.ts\\'"  . typescript-ts-mode)
             ("\\.jsx\\'" . tsx-ts-mode))
      :preface
      (defun os/setup-install-grammars ()
        "Install Tree-sitter grammars if they are absent."
        (interactive)
        (dolist (grammar
                 '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
                   (bash "https://github.com/tree-sitter/tree-sitter-bash")
                   (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
                   (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
                   (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
                   (cmake "https://github.com/uyha/tree-sitter-cmake")
                   (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
                   (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
                   (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))))
          (add-to-list 'treesit-language-source-alist grammar)
          (unless (treesit-language-available-p (car grammar))
            (treesit-install-language-grammar (car grammar)))))

      (dolist (mapping
               '(
                 (css-mode . css-ts-mode)
                 (typescript-mode . typescript-ts-mode)
                 (js-mode . typescript-ts-mode)
                 (js2-mode . typescript-ts-mode)
                 (bash-mode . bash-ts-mode)
                 (css-mode . css-ts-mode)
                 (json-mode . json-ts-mode)
                 (js-json-mode . json-ts-mode)
                 ))
        (add-to-list 'major-mode-remap-alist mapping))
      :config
      (os/setup-install-grammars))

(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
          (agda "https://github.com/tree-sitter/tree-sitter-agda")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))


(use-package! agda2-mode :mode (("\\.l?agda\\'" . agda2-mode)
                                ("\\.lagda.md\\'" . agda2-mode)))
(use-package! haskell-mode
  :mode ("\\.hs\\'")
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

(use-package! rust-ts-mode
  :mode ("\\.rs" . rust-ts-mode)
  :hook (rust-ts-mode . eglot))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(remove-hook 'rust-mode-hook 'flycheck-mode)
