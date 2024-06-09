(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq doom-fallback-buffer-name "*dashboard*")
;; ;; Emacs Dashboard tweaks
(use-package! dashboard
  :init
  (setq
   dashboard-startup-banner (concat doom-user-dir "misc/e-logo.svg")
   dashboard-set-heading-icons t
   dashboard-set-file-icons t
   dashboard-show-shortcuts t
   dashboard-center-content t
   dashboard-vertically-center-content t
   dashboard-items '((recents  . 5)
                     (projects . 5))
   dashboard-projects-backend 'projectile
   dashboard-week-agenda nil
   dashboard-icon-type 'nerd-icons
   dashboard-display-icons-p t)
  :config
  (dashboard-setup-startup-hook))
