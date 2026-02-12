(use-package! eglot
  :init
  (setq eglot-autoshutdown t)
  :config
  (setq eglot-ignored-server-capabilities '(:documentLinkProvider :inlayHintProvider :documentOnTypeFormattingProvider))
  (electric-pair-mode)
  (add-to-list 'eglot-server-programs '(scala-mode "metals"))
  (add-to-list 'eglot-server-programs '(lua-mode "lua-language-server"))
  (add-to-list 'eglot-server-programs '(rjsx-mode .("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tuareg-mode "ocamllsp"))
  (add-to-list 'eglot-server-programs '(ruby-mode "solargraph" "stdio"))
  (add-to-list 'eglot-server-programs '(lean4-mode . ("lake" "serve")))
  (add-to-list 'eglot-server-programs '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-to-list 'eglot-server-programs '(tsx-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(typescript-ts-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               `(rustic-mode . ("rust-analyzer" :initializationOptions
                                (:procMacro (:enable t)
                                 :cargo (:buildScripts (:enable t))))))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq eldoc-documentation-functions
                    (cons #'flymake-eldoc-function
                          (remove #'flymake-eldoc-function eldoc-documentation-functions)))
              (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

  :hook
  ((rjsx-mode tuareg-mode lean4-mode rustic-mode tsx-ts-mode typescript-ts-mode js2-mode scala-mode agda2-mode haskell-mode idris-mode lua-mode ruby-mode) . eglot-ensure))

(add-hook 'rustic-mode-hook (lambda () (flycheck-mode -1)))

(use-package! eglot-booster
  :after eglot
  :config (eglot-booster-mode))

(use-package! kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-blend-background nil)
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


(after! corfu
  (setq
   corfu-auto t
   corfu-auto-delay 0.2
   corfu-auto-prefix 2
   corfu-min-width 30
   corfu-max-width 70
   corfu-echo-documentation nil
   corfu-cycle t
   corfu-preselect 'prompt))

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
         ("\\.jsx\\'" . typescript-ts-mode))
  :config
  (setq typescript-ts-mode-indent-offset 4)
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))

(use-package! treesit
  :mode (("\\.tsx\\'" . tsx-ts-mode)
         ("\\.js\\'"  . typescript-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.rb\\'"  . ruby-ts-mode)
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
               (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
               (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))))
      (add-to-list 'treesit-language-source-alist grammar)
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))

  (dolist (mapping
           '((css-mode . css-ts-mode)
             (typescript-mode . typescript-ts-mode)
             (js-mode . typescript-ts-mode)
             (js2-mode . typescript-ts-mode)
             (css-mode . css-ts-mode)
             (json-mode . json-ts-mode)
             (js-json-mode . json-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))
  :config
  (os/setup-install-grammars))

(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
          (agda "https://github.com/tree-sitter/tree-sitter-agda")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))

(use-package! sh-mode
  :mode (("\\.sh\\'" . sh-mode)
         ("\\.zsh\\'" . sh-mode)
         ("\\.env\\'" . sh-mode)
         ("\\.zshrc\\'" . sh-mode)))

(after! sh-mode
  (setq-hook! 'sh-mode-hook +lsp-buffer-mode -1))

(use-package! agda2-mode
  :mode ("\\.agda\\'" "\\.lagda.md\\'")
  :config
  (load-file (let ((coding-system-for-read 'utf-8))
               (shell-command-to-string "agda-mode locate"))))

(after! agda2-mode
  (setq agda2-program-args '("--guardedness")))

(use-package! haskell-mode
  :mode ("\\.hs\\'")
  :config
  (setq haskell-interactive-popup-errors nil
        haskell-indentation-layout-offset  4
        haskell-indentation-starter-offset 4
        haskell-indentation-left-offset    4
        haskell-indentation-where-pre-offset  4
        haskell-indentation-where-post-offset 4)

  (add-to-list 'exec-path "/home/luis/.ghcup/bin")
  (setenv "PATH" (concat "/home/luis/.ghcup/bin:" (getenv "PATH")))

  (add-hook 'haskell-mode-hook
            (lambda ()
              (setq-local eglot-workspace-configuration
                          '((haskell (formattingProvider . "ormolu"))))
              (eglot-ensure)
              (add-hook 'before-save-hook #'eglot-format-buffer -10 t))))

(add-hook 'haskell-mode-hook (lambda () (flycheck-mode -1)))

(use-package! idris-mode
  :mode ("\\.idr\\'")
  :custom
  (idris-interpreter-path "idris2"))

(use-package! rust-ts-mode
  :mode ("\\.rs" . rust-ts-mode)
  :hook (rust-ts-mode . eglot-ensure))

(use-package! lua-mode
  :mode ("\\.lua\\'"))

(use-package! flycheck
  :hook eglot
  :custom
  (flymake-show-diagnostics-at-end-of-line t)
  :bind (:map global-map
              ("M-n" . #'flymake-goto-next-error)
              ("M-p" . #'flymake-goto-prev-error))
  :config
  (flycheck-set-indication-mode 'left-fringe))

(global-prettify-symbols-mode 1)

(defun haskell-pretty-mode ()
  "Set up pretty symbols for haskell"
  (setq prettify-symbols-alist
        '(("lambda" .  ?\u03BB)
          ("\\" . ?\u03BB)
          ("->" . ?\u2192)
          ("<-" . ?\u2190)
          ("=>" . ?\u21D2)))
  (prettify-symbols-mode 1))

(defvar haskell-font-lock-symbols)
(setq haskell-font-lock-symbols t)
(add-hook 'haskell-mode-hook 'haskell-pretty-mode)

(defun my-pretty-mode ()
  (interactive)
  (setq prettify-symbols-alist scala-prettify-symbols-alist)
  (setq prettify-symbols-unprettify-at-point t)
  (prettify-symbols-mode))

(after! lsp-metals
  (setq lsp-metals-server-args '("-Dmetals.workspace-symbol-search-excludes=target/**"))
  (setq lsp-metals-compile-on-save nil)
  (setq lsp-metals-treeview-logging-enabled nil)
  (setq lsp-metals-server-command "metals-emacs")
  (setq lsp-metals-super-method-lenses-enabled nil))

(use-package! scala-mode
  :mode ("\\.sc\\'" "\\.scala\\'"))

(after! scala-mode
  (setq scala-indent:align-forms t
        scala-indent:align-parameters t
        scala-indent:default-run-on-strategy scala-indent:operator-strategy))

(use-package! lsp-metals
  :disabled t
  :hook (scala-mode . lsp))

(after! flymake
  (setq flymake-no-changes-timeout 0.5)
  (define-key flymake-mode-map (kbd "M-n") #'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") #'flymake-goto-prev-error))

(after! company
  (setq-default company-backends '(company-capf)))

(add-hook 'ruby-mode-hook (lambda () (flycheck-mode -1)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      (lambda ()
                        (when (eq major-mode 'ruby-mode)
                          (let ((point-before (point)))
                            (shell-command-on-region
                             (point-min) (point-max)
                             "rufo -x"
                             (current-buffer) t)
                            (goto-char point-before))))
                      -10 t)))
