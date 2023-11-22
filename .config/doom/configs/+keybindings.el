(map! :leader
      :prefix "o"
      :desc "Open .dotfiles folder"
      :n "p" #'dired "$HOME/.dotfiles/.config")
(map! :leader
      :desc "Perform Rg search"
      "r g" #'+ivy/project-search)
(map! :g "C-z" #'undo)
(map! :nvig "C-'" #'er/expand-region)
(map!
 :map LaTeX-mode-map
 :leader
 :desc "View" "v" #'TeX-view)

