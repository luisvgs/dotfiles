;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; (setq fancy-splash-image (concat doom-user-dir "misc/emacs.svg"))
;; (add-hook! '+doom-dashboard-functions :append
;;   (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Welcome home, Luis.")))
;; (add-hook 'exwm-init-hook #'+doom-dashboard/open)
(setq initial-buffer-choice 'dashboard-open)
(after! dashboard
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard"
        dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-show-shortcuts nil)
  (dashboard-setup-startup-hook))
