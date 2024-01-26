(package! latex-preview-pane)
(package! ef-themes)
(package! corfu :pin "45480f581dede5e08383e03da9131b8e6fae44a1") ;; workaround for eglot related issue
(package! nerd-icons-corfu)
(package! doom-modeline :pin "bf880ae56f3f6aab7bd334de9bd9b455c63a24c0") ;; workaround for jsonrpc issue
(package! corfu-terminal
  :recipe (:host nil :repo "https://codeberg.org/akib/emacs-corfu-terminal"))

(disable-packages! dashboard jbeans-theme nodejs-repl coffee-mode skewer-mode all-the-icons)
