(defun my-weebery-is-always-greater ()
  (let* ((banner '(
                   "______ _____ ____ ___ ___"
                   "`  _  V  _  V  _ \\|  V  ´"
                   "| | | | | | | | | |     |"
                   "| | | | | | | | | | . . |"
                   "| |/ / \\ \\| | |/ /\\ |V| |"
                   "|   /   \\__/ \\__/  \\| | |"
                   "|  /                ' | |"
                   "| /     E M A C S     \\ |"
                   "´´                     ``"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))
(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

;; (setq fancy-splash-image (concat doom-user-dir "misc/e-logo.svg"))
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
;; (remove-hook 'doom-after-init-hook #'doom-display-benchmark-h)

;; (add-hook! '+doom-dashboard-functions :append
;;   (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Welcome to Emacs!")))
(setq fancy-splash-image (concat doom-user-dir "misc/e-logo.svg"))
(setq +doom-dashboard-menu-sections nil)
(defun doom-dashboard-widget-shortmenu ())
(defun doom-dashboard-widget-footer ())
(defun doom-dashboard-widget-loaded ()
  (when doom-init-time
    (insert
     ""
     (propertize
      (+doom-dashboard--center
       +doom-dashboard--width
       "Welcome home")
      'face 'doom-dashboard-loaded)
     "\n")))

;; Emacs Dashboard tweaks
;; (use-package! dashboard
;;   :init
;;   (setq dashboard-startup-banner (concat doom-user-dir "misc/gnu_color.svg")
;;         dashboard-set-footer nil
;;         dashboard-set-navigator nil
;;         dashboard-set-heading-icons t
;;         dashboard-set-init-info t
;;         dashboard-set-file-icons t
;;         dashboard-show-shortcuts nil
;;         dashboard-center-content nil
;;         dashboard-items '((recents  . 5)
;;                           (projects . 5)
;;                           (agenda . 8))
;;         dashboard-projects-backend 'projectile
;;         ;; dashboard-match-agenda-entry "ROUTINE=\"ROUTINE\""
;;         dashboard-filter-agenda-entry 'dashboard-no-filter-agenda
;;         dashboard-week-agenda t
;;         dashboard-icon-type 'nerd-icons
;;         dashboard-display-icons-p t)
;;   :config
;;   (dashboard-setup-startup-hook))
