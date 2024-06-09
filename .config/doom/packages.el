(package! latex-preview-pane)
;; (package! corfu :pin "45480f581dede5e08383e03da9131b8e6fae44a1")
;; (package! nerd-icons-corfu)
;; (package! corfu-terminal
;;   :recipe (:host nil :repo "https://codeberg.org/akib/emacs-corfu-terminal"))
(package! modus-themes)
(package! scala-repl)
(package! apropospriate-theme)
(package! dashboard)
(package! nyan-mode)
(package! toggle-term)
(package! evil-cleverparens)
(package! eglot-booster
  :recipe (:host github :repo "jdtsmith/eglot-booster"
           :files ("*")))
(disable-packages! android-mode groovy-mode nodejs-repl coffee-mode skewer-mode all-the-icons)
