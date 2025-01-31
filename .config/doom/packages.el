(package! latex-preview-pane)
(package! modus-themes)
(package! ef-themes)
(package! dired-preview)
(package! dmenu)
(package! telega)
(package! scala-repl)
(package! drag-stuff)
(package! treesit-auto)
(package! kind-icon)
(package! ng2-mode)
(package! exwm-modeline)
(package! disproject)
(package! lsp-sonarlint)
(package! spacemacs-theme)
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover-community/lean4-mode"
   :files ("*.el" "data")))
(package! emacs-eat :recipe
  (:host codeberg
   :repo "akib/emacs-eat"
   :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))))
(package! standard-themes)
(package! grandshell-theme)
(package! evil-cleverparens)
(package! exwm)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))
(disable-packages! android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons tuareg-mode idris-mode)


