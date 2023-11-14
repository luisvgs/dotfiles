(map! :map evil-window-map
      "SPC" #'rotate-layout
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C -<right>"      #'+evil/window-move-right)

(map! :map evil-window-map
      :leader
      :prefix "w"
      :desc "evil-window-increase-width" "," (cmd! (evil-window-increase-width 20))
      :desc "evil-window-decrease-width" "." (cmd! (evil-window-decrease-width 20))
      :desc "evil-window-increase-height" "'" (cmd! (evil-window-increase-height 5))
      :desc "evil-window-decrease-height" ";" (cmd! (evil-window-decrease-height 5)))

(map! :map evil-normal-state-map "C-k" #'next-buffer)
(map! :map evil-normal-state-map "C-j" #'previous-buffer)
;; (map! :map evil-normal-state-map "s-]" #'next-buffer)
;; (map! :map evil-normal-state-map "s-[" #'previous-buffer)


(setq evil-vsplit-window-right t
      evil-split-window-below t)
