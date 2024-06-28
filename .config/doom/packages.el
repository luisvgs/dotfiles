(package! latex-preview-pane)
;; (package! corfu :pin "45480f581dede5e08383e03da9131b8e6fae44a1")
;; (package! nerd-icons-corfu)
;; (package! corfu-terminal
;;   :recipe (:host nil :repo "https://codeberg.org/akib/emacs-corfu-terminal"))
(package! modus-themes)
(package! ef-themes)
(package! scala-repl)
(package! apropospriate-theme)
(package! treesit-auto)
(package! jetbrains-darcula-theme)
(package! nyan-mode :disable t)
(package! mu4e-alert)
(package! evil-cleverparens)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))
(disable-packages! rust-mode android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons)
