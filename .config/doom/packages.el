(package! latex-preview-pane)
(package! modus-themes)
(package! ef-themes)
(package! rg)
(package! dmenu)
(package! drag-stuff)
(package! evil-goggles)
(package! treesit-auto)
(package! kind-icon)
(package! ng2-mode)
(package! exwm-modeline)
(package! disproject)
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover-community/lean4-mode"
   :files ("*.el" "data")))
(package! why-this :recipe
  (:host codeberg
   :repo "akib/emacs-why-this"))
(package! evil-cleverparens)
(package! exwm)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))


(disable-packages! android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons tuareg-mode idris-mode)
