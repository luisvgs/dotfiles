(after! consult
  (setq consult-ripgrep-args "rg --no-ignore --hidden --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number ."))
