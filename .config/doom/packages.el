(package! latex-preview-pane)
(package! modus-themes)
(package! jbeans-theme)
(package! ef-themes)
(disable-packages! modus-themes nerd-icons nodejs-repl coffee-mode skewer-mode)
(package! doom-modeline :pin "6125309c2caa")
(package! lean4-mode :disable t
  :recipe
  (:host github
   :repo "leanprover/lean4-mode"
   :files ("*.el" "data")))
