(use-package! lsp-mode
  :defer t
  :hook
  (rust-mode . lsp)
  (json-mode . lsp)
  (sh-mode . lsp)
  (scala-mode . lsp)
  (c++-mode . lsp)
  (c-mode . lsp)
  (agda2-mode . lsp)
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

(use-package! ccls
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package! flycheck
  :init (global-flycheck-mode)
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error) ; optional but recommended error navigation
              ("M-p" . flycheck-previous-error)))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
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
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)


(defvar jpalmer/typescript-treesit-auto-recipe
  (make-treesit-auto-recipe
   :lang 'typescript
   :ts-mode 'typescript-ts-mode
   :remap 'typescript-mode
   :url "https://github.com/tree-sitter/tree-sitter-typescript"
   :revision "v0.20.3"
   :source-dir "typescript/src"
   :ext "\\.ts\\'")
  "Recipe for treesitter typescript lib")
(add-to-list 'treesit-auto-recipe-list jpalmer/typescript-treesit-auto-recipe)

(when (treesit-available-p)
  (add-to-list 'major-mode-remap-alist '(js2-mode . js-ts-mode))
  (add-to-list 'major-mode-remap-alist '(typescript-mode . typescript-ts-mode))
  (add-to-list 'major-mode-remap-alist '(json-mode . json-ts-mode)))

(setq major-mode-remap-alist
      '((bash-mode . bash-ts-mode)
        (js2-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode . json-ts-mode)))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-eldoc-enable-hover nil
        lsp-eldoc-render-all nil
        lsp-eldoc-enable-hover nil
        eldoc-documentation-functions nil
        (setq lsp-ui-sideline-enable t)
        (setq lsp-ui-sideline-show-diagnostics t)
        (setq lsp-ui-sideline-show-hover t)
        (setq lsp-ui-peek-always-show t)
        ;; (setq lsp-ui-doc-enable nil)
        ))
