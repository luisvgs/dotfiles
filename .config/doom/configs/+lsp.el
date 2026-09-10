;;; configs/+lsp.el -*- lexical-binding: t; -*-

(setq lsp-keymap-prefix "C-c l")

(use-package! lsp-mode
  :defer t
  :config
  (setq lsp-completion-provider :none
        lsp-diagnostics-provider :flymake
        lsp-keep-workspace-alive nil
        lsp-log-io nil
        lsp-idle-delay 0.3
        lsp-enable-on-type-formatting nil
        lsp-enable-links nil
        lsp-lens-enable t
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all nil
        lsp-modeline-code-actions-enable t
        lsp-headerline-breadcrumb-enable nil)
  :hook
  ((c-ts-mode . lsp)
   (c++-ts-mode . lsp)
   (ruby-mode . lsp)
   (lean4-mode . lsp)
   (typescript-ts-mode . lsp)
   (tsx-ts-mode . lsp)
   (haskell-mode . lsp)
   (idris-mode . lsp)))

(use-package! ruby-mode
  :mode "\\.rb\\'")

(after! lsp-ui
  (setq lsp-ui-peek-enable t
        lsp-ui-peek-always-show t
        lsp-ui-peek-show-directory t
        lsp-ui-doc-enable t
        lsp-ui-sideline-enable nil))

(after! lsp-clangd
  (setq lsp-clients-clangd-args
        '("--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--compile-commands-dir=build")))

(after! c-ts-mode
  (setq c-ts-mode-indent-style 'k&r
        c-ts-mode-indent-offset 4))

(use-package! electric-pair-mode
  :hook ((c++-ts-mode . electric-pair-local-mode)
         (c-ts-mode . electric-pair-local-mode)))

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "ormolu"))

(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs\\'" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-ts-mode))

(add-hook 'haskell-mode-hook
          (lambda ()
            (when (bound-and-true-p flycheck-mode)
              (flycheck-mode -1))))

(after! rustic
  (setq rustic-lsp-client 'lsp-mode))

(after! lsp-rust
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-cargo-run-build-scripts t))

(add-hook 'rustic-mode-hook
          (lambda ()
            (setq-local lsp-inlay-hint-enable nil)))

(after! lsp-metals
  (setq lsp-metals-server-args
        '("-Dmetals.workspace-symbol-search-excludes=target/**")
        lsp-metals-compile-on-save nil
        lsp-metals-treeview-logging-enabled nil
        lsp-metals-server-command "metals-emacs"
        lsp-metals-super-method-lenses-enabled nil))

(map! :map lsp-mode-map
      "C-c d" #'lsp-describe-thing-at-point)

(map! :leader
      :prefix "c"
      :desc "Peek references"
      "p" #'lsp-ui-peek-find-references)

(after! flymake
  (remove-hook 'flymake-diagnostic-functions
               #'flymake-proc-legacy-flymake))


(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)


(after! smartparens
  (sp-local-pair '(c-mode c++-mode c-ts-mode c++-ts-mode)
                 "{"
                 nil
                 :post-handlers '(("||\n[i]" "RET"))))

(map! :map c-ts-base-mode-map
      "C-c f l" #'flycheck-list-errors
      "C-c f c" #'consult-flycheck)

(map! :map (ruby-mode-map)
      :desc "Describe worspace symbols"
      "C-c S" #'lsp-workspace-symbol)


(add-hook 'ruby-mode-hook
          (lambda ()
            (setq-local lsp-enabled-clients '(ruby-lsp-ls))
            (setq-local lsp-semantic-tokens-enable t
                        lsp-ui-sideline-enable t
                        lsp-ui-sideline-show-hover t
                        lsp-ui-sideline-show-code-actions t
                        lsp-ui-sideline-delay 0.2)))
