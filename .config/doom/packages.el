(package! latex-preview-pane)
(package! modus-themes)
(disable-packages! nerd-icons nodejs-repl coffee-mode skewer-mode)
(package! doom-modeline :pin "6125309c2caa")
(package! lean4-mode :disable t
  :recipe
  (:host github
   :repo "leanprover/lean4-mode"
   :files ("*.el" "data")))
