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

(map! :g "C-t" #'+treemacs/toggle)

(map! :leader
      :desc "Open journal file"
      "o j" (lambda () (interactive) (find-file "~/org/journal.org")))

(map! :g "C-c x" #'query-replace)

(map! :leader
      :desc "Toggle treemacs"
      "-" #'+treemacs/toggle)
