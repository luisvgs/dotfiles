(use-package! corfu
  :defer t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :init
  (corfu-popupinfo-mode)
  (global-corfu-mode)
  ;;(global-completion-preview-mode)
  :config
  (setq
   corfu-popupinfo-delay 0.2
   corfu-auto-delay 0.25
   corfu-auto-prefix 2)
  (map!
   :map corfu-map
   "M-p" #'corfu-popupinfo-scroll-down
   "M-n" #'corfu-popupinfo-scroll-up
   "M-d" #'corfu-popupinfo-toggle))

