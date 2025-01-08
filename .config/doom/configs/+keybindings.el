(map! :leader
      :prefix "o"
      :desc "Open .dotfiles folder"
      :n "p" #'dired "$HOME/.dotfiles/.config")
(map! :leader
      :desc "Perform Rg search"
      "r g" #'consult-ripgrep)
(map! :g "C-z" #'undo)
(map! :nvig "C-'" #'er/expand-region)
(map!
 :map LaTeX-mode-map
 :leader
 :desc "View" "v" #'TeX-view)

(map! :g "C-s" #'consult-line)
(map! :g "C-\\" #'eat)
;; (map! :g "C-\\" #'+treemacs/toggle)

(map! :leader
      :desc "Open journal file"
      "o j" (lambda () (interactive) (find-file "~/org/journal.org")))

(map! :g "C-c x" #'query-replace)

(map! :leader
      :desc "Show diff for the file in the current buffer."
      "g d" #'magit-diff-buffer-file)

(map! :leader
      :desc "Create a branch from current stash changes."
      "g z" #'magit-stash-branch)

(map! :g "C-x v ~" #'magit-find-file-other-window)

(map! :g "C-w" #'kill-region)
(map! :g "C-c C-f C-f" #'+fold/toggle)
