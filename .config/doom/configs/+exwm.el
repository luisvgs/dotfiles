(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)
(use-package! exwm-modeline
  :after exwm)
(add-hook 'exwm-init-hook #'exwm-modeline-mode)

(use-package! dmenu
  :after exwm)

(defun running-in-exwm-p ()
  "Return t if the current session is running under EXWM."
  (and (eq window-system 'x)
       (string= (getenv "DESKTOP_SESSION") "exwm")))

(when (running-in-exwm-p)
  (defun exwm/exwm-update-class ()
    (exwm-workspace-rename-buffer exwm-class-name))

  (defun exwm/exwm-init-hook ()
    (exwm-workspace-switch-create 1))

  (defun exwm/configure-window-by-class ()
    (interactive)
    (pcase exwm-class-name
      ("Firefox" (exwm-workspace-move-window 3))
      ("Google-chrome" (exwm-workspace-move-window 2))
      (exwm-layout-toggle-mode-line)))

  (use-package exwm
    :config
    (setq exwm-workspace-number 6)
    (add-hook 'exwm-update-class-hook #'exwm/exwm-update-class)
    (add-hook 'exwm-init-hook #'exwm/exwm-init-hook)
    (add-hook 'exwm-manage-finish-hook #'exwm/configure-window-by-class)
    (require 'exwm-randr)
    (exwm-randr-mode t)
    (start-process-shell-command "xrandr" nil "xrandr --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal && xrandr --output eDP-1 --off")

    (require 'exwm-systemtray)
    (setq exwm-systemtray-height 32)
    (exwm-systemtray-mode t)

    (setq exwm-layout-show-all-buffers t)
    (setq exwm-workspace-show-all-buffers t)
    (setq display-time-day-and-date t)
    (display-time-mode 1)
    (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
    (setq
     exwm-input-simulation-keys '(([?\s-F] .[?\C-f])
                                  )
     exwm-input-prefix-keys
     '(?\C-x
       ?\C-u
       ?\C-h
       ?\M-x
       ?\M-`
       ?\M-&
       ?\M-:
       ?\C-\M-j
       ?\C-\ )
     exwm-input-global-keys
     `(
       ([?\s-r] . exwm-reset)
       ([s-left] . windmove-left)
       ([s-right] . windmove-right)
       ([s-up] . windmove-up)
       ([s-down] . windmove-down)

       ([?\s-d] . dired)
       ([s-S-return] . dmenu)
       ([s-return] . vterm)

       ;; QoL
       ([?\s-B] . kill-current-buffer)
       ([?\s-w] . exwm-workspace-switch)
       ([?\s-C] . +workspace/close-window-or-workspace)

       ;; change window focus with super+h,j,k,l
       ([?\s-h] evil-window-left)
       ([?\s-j] evil-window-next)
       ([?\s-k] evil-window-prev)
       ([?\s-l] evil-window-right)
       ;; ([?\s-tab] exwm-workspace-switch-to-last)

       ;; move windows around using SUPER+SHIFT+h,j,k,l
       ([?\s-H] +evil/window-move-left)
       ([?\s-J] +evil/window-move-down)
       ([?\s-K] +evil/window-move-up)
       ([?\s-L] +evil/window-move-right)

       ;; move window to far left or far right with SUPER+CTRL+h, L
       ([?\s-\C-h] side-bottom-window)
       ([?\s-\C-j] side-left-window)
       ([?\s-\C-l] side-right-Window)

       ([?\s-\C-d] resize-window)
       ([?\s-\C-r] side-window-delete-all)

       ([?\s-z] . evil-window-split)
       ([?\s-v] . evil-window-vsplit)
       ([f11] . exwm-layout-toggle-fullscreen)

       ([?\s-&] . (lambda (command)
                    (interactive (list (read-shell-command "$ ")))
                    (start-process-shell-command command nil command)))

       ([?\s-f] . (lambda ()
                    (interactive)
                    (start-process "" nil "google-chrome-stable")))


       ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
       ,@(mapcar (lambda (i)
                   `(,(kbd (format "s-%d" i)) .
                     (lambda ()
                       (interactive)
                       (exwm-workspace-switch-create ,i))))
                 (number-sequence 0 9))))

    (setq window-divider-default-right-width 1)
    (window-divider-mode 1)
    (exwm-enable))

  (setq mouse-autoselect-window t)
  (setq focus-follows-mouse t)
  (setq exwm-workspace-warp-cursor t))
