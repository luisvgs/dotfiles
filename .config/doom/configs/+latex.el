(setq +latex-viewers '(zathura))

(after! pdf-tools
  (add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode))
