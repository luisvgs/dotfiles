;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; (setq fancy-splash-image (concat doom-user-dir "misc/emacs.svg"))
;; (add-hook! '+doom-dashboard-functions :append
;;   (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Welcome home, Luis.")))
;; (add-hook 'exwm-init-hook #'+doom-dashboard/open)
(setq initial-buffer-choice 'dashboard-open)
(after! dashboard
  (setq dashboard-banner-logo-title "Welcome to Emacs."
        dashboard-icon-type 'nerd-icons
        dashboard-set-file-icons t
        dashboard-set-heading-icons t
        dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-show-shortcuts t
        dashboard-items '((recents   . 5)
                          (bookmarks . 10)
                          (projects  . 5)))
  (dashboard-setup-startup-hook))
