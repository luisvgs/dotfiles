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
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Welcome to Emacs!")))
