(use-package! lsp-mode
  :defer t
  :disabled t
  :hook
  (rust-mode . lsp)
  (json-mode . lsp)
  (sh-mode . lsp)
  (scala-mode . lsp)
  (java-mode . lsp)
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
;; FIX to work with eglot
;; (after! lsp-java
;;   (setq lombok-library-path (concat doom-data-dir "lombok.jar"))
;;   (unless (file-exists-p lombok-library-path)
;;     (url-copy-file "https://projectlombok.org/downloads/lombok.jar" lombok-library-path))
;;   (setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms100m"))
;;   (push (concat "-javaagent:"
;;                 (expand-file-name lombok-library-path))
;;         lsp-java-vmargs))

;; (defvar java-lombok-jar-path (concat doom-data-dir "lombok.jar")
;;   "The path of lombok.jar")
;; (use-package! lsp-java
;;   :config
;;   (when (file-exists-p java-lombok-jar-path)
;;     (add-to-list 'lsp-java-vmargs (concat "-javaagent:" java-lombok-jar-path))))


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

;; (use-package! lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :config
;;   (setq lsp-eldoc-enable-hover nil
;;         lsp-eldoc-render-all nil
;;         lsp-eldoc-enable-hover nil
;;         eldoc-documentation-functions nil
;;         ;; (setq lsp-ui-sideline-enable t)
;;         ;; (setq lsp-ui-sideline-show-diagnostics t)
;;         ;; (setq lsp-ui-sideline-show-hover t)
;;         ;; (setq lsp-ui-peek-always-show nil)
;;         ;; (setq lsp-ui-doc-enable nil)
;;         ))
