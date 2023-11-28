(package! latex-preview-pane)
(package! ef-themes)
(package! lean4-mode :recipe
  (:host github
   :repo "leanprover/lean4-mode"
   :files ("*.el" "data")))
(package! corfu)
(package! nerd-icons-corfu)
;; (package! dired-preview)
(disable-packages! dashboard jbeans-theme nodejs-repl coffee-mode skewer-mode all-the-icons)
