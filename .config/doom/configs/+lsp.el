(use-package! lsp-mode
  :defer t
  :hook
  (rustic-mode . lsp)
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

;; (setq lsp-java-vmargs
;;       (list
;;        "-noverify"
;;        "-Xmx1G"
;;        "-XX:+UseG1GC"
;;        "-XX:+UseStringDeduplication"
;;        "-javaagent:/home/luis/Downloads/lombok.jar"))
;; Java Configuration
(after! lsp-java
  (setq lombok-library-path (concat doom-data-dir "lombok.jar"))
  (unless (file-exists-p lombok-library-path)
    (url-copy-file "https://projectlombok.org/downloads/lombok.jar" lombok-library-path))
  (setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx4G" "-Xms100m"))
  (push (concat "-javaagent:"
                (expand-file-name lombok-library-path))
        lsp-java-vmargs))

(defvar java-lombok-jar-path (concat doom-data-dir "lombok.jar")
  "The path of lombok.jar")
(use-package! lsp-java
  :config
  (when (file-exists-p java-lombok-jar-path)
    (add-to-list 'lsp-java-vmargs (concat "-javaagent:" java-lombok-jar-path))))


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
