(package! compile-angel)
(package! dashboard)
(package! mu4e-alert)
(package! modus-themes)
(package! ef-themes)
(package! jbeans-theme)
(package! rg)
(package! dmenu)
(package! spacemacs-theme)
(package! drag-stuff)
(package! treesit-auto)
(package! nyan-mode)
(package! kind-icon)
(package! exwm-modeline)
(package! app-launcher
  :recipe
  (:host github
   :repo "sebastienWae/app-launcher"
   :files ("*")))
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover-community/lean4-mode"
   :files ("*.el" "data")))
(package! evil-cleverparens)
(package! exwm)
(package! eglot-fsharp)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))
(package! grandshell-theme)
(package! qutebrowser
  :recipe (:host github
           :repo "lrustand/qutebrowser.el"
           :files (:defaults ".py")))
;;org stuff
(package! org-fancy-priorities)
(package! org-superstar)
;; (package! org-roam-ui)
(package! easysession)
(package! transpose-frame
  :recipe (:local-repo "local/transpose-frame"))

(disable-packages! ng2-mode android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons tuareg-mode idris-mode)
