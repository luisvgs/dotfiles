(use-package! company
  :after eglot
  :diminish
  :hook (eglot . company-mode)
  :config
  (setq company-idle-delay 0.5))
