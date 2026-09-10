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
               (markdown . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                            "split_parser" "tree-sitter-markdown/src"))
               (markdown-inline . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown"
                                   "split_parser" "tree-sitter-markdown-inline/src"))
               (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
               (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
               (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
               (cmake "https://github.com/uyha/tree-sitter-cmake")
               (cpp "https://github.com/tree-sitter/tree-sitter-cpp")

               (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
               (agda "https://github.com/tree-sitter/tree-sitter-agda")
               (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby" "v0.21.0"))
               (agda
                "https://github.com/tree-sitter/tree-sitter-agda")
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
             (ruby-mode . ruby-ts-mode)
             (js-json-mode . json-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))
  :config
  (os/setup-install-grammars))

