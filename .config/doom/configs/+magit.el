;; (use-package! magit
;;   :config
;;   (setq magit-branch-read-upstream-first 'fallback)
;;   :commands magit-status)
(after! magit
  (setq magit-branch-read-upstream-first 'fallback))
