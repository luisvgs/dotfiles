;; (package! latex-preview-pane)
(package! modus-themes)
(package! ef-themes)
(package! rg)
(package! dmenu)
(package! smart-mode-line )
(package! spacemacs-theme)
(package! drag-stuff)
(package! evil-goggles)
(package! ccls)
(package! treesit-auto)
(package! kind-icon)
(package! exwm-modeline)
(package! app-launcher :recipe (
  :host github :repo "sebastienWae/app-launcher" :files ("*")))
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover-community/lean4-mode"
   :files ("*.el" "data")))
(package! evil-cleverparens)
(package! exwm)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))
(package! minions)
(package! auctex)


(disable-packages! android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons tuareg-mode idris-mode)
