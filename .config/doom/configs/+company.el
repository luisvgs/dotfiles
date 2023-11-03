(use-package! company
  :disabled t
  :after eglot
  :diminish
  :hook (eglot . company-mode)
  :config
  (setq company-idle-delay 0.5))

(use-package! corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :hook ((rustic-mode . corfu-mode)
         (eglot . corfu-mode)
         (lean4-mode . corfu-mode)
         (scala-mode . corfu-mode))
  :init
  (corfu-popupinfo-mode)
  (global-corfu-mode)
  :config
  (setq corfu-popupinfo-delay 0.5)
  (map!
   :map corfu-map
   "M-p" #'corfu-popupinfo-scroll-down
   "M-n" #'corfu-popupinfo-scroll-up
   "M-d" #'corfu-popupinfo-toggle))

(use-package! nerd-icons-corfu
  :after ( nerd-icons corfu )
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))
