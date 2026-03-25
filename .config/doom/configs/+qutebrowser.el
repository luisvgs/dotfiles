(use-package! qutebrowser
  :after exwm
  :config
  (unless (server-running-p)
    (server-start))
  (global-qutebrowser-exwm-mode 1)
  (qutebrowser-theme-export-mode 1))
