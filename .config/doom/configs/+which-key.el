(use-package! which-key
  :defer t
  :diminish which-key-mode
  :init
  (setq which-key-show-early-on-C-h t
        which-key-idle-delay 10000
        which-key-idle-secondary-delay 0.05))
