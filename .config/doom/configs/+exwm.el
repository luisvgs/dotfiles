(defun exwm/shutdown ()
  (interactive)
  (when (yes-or-no-p "Are you sure you want to shutdown")
    shell-command "shutdown now"))

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

(defun exwm/setup-displays ()
  "Configure displays based on what's connected."
  (let ((hdmi-connected (string-match-p "HDMI-2 connected"
                                        (shell-command-to-string "xrandr"))))
    (if hdmi-connected
        (start-process-shell-command
         "xrandr" nil
         "xrandr --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --off")
      (start-process-shell-command
       "xrandr" nil
       "xrandr --output eDP-1 --primary --auto --output HDMI-2 --off"))))

(defun running-in-exwm-p ()
  "Return t if the current session is running under EXWM."
  (and (eq window-system 'x)
       (string= (getenv "DESKTOP_SESSION") "exwm")))

(defun exwm/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

;; Update panel indicator when workspace changes
(defun exwm/set-wallpaper ()
  (interactive)
  (start-process-shell-command
   "feh" nil "feh --bg-fill ~/.config/wallpapers/space.png"))

(defun exwm/exwm-init-hook ()
  (start-process-shell-command "redshift" nil "redshift -O 4100")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (exwm/set-wallpaper)
  (exwm-workspace-switch-create 1))

(defun exwm/configure-window-by-class ()
  (interactive)
  (pcase exwm-class-name
    ("Telegram" (exwm-workspace-move-window 3))
    ("Kitty" (exwm-workspace-move-window 1))
    ("Thunar" (exwm-workspace-move-window 8))
    ("Google-chrome" (exwm-workspace-move-window 2))
    (_ nil)))


(defun my/close-window-or-buffer ()
  (interactive)
  (cond
   ((derived-mode-p 'exwm-mode)
    (exwm-input-send-key (kbd "C-q")))
   ((> (length (window-list)) 1)
    (delete-window))
   (t
    (kill-buffer))))

(defun my/kill-current-window ()
  (interactive)
  (if (derived-mode-p 'exwm-mode)
      (exwm-manage--kill-buffer-and-window)
    (kill-current-buffer)))

(defun my/brightness-up ()
  "Aumenta el brillo de la pantalla usando brightnessctl y muestra una notificación."
  (interactive)
  (start-process-shell-command "brightness-up" nil "brightnessctl set +5%")
  (let* ((current-brightness (shell-command-to-string "brightnessctl get | awk '{printf \"%d\", ($1 > 100 ? 100 : $1)}'"))
         (display-brightness (string-trim current-brightness)))
    (start-process-shell-command "notify-brightness-up" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness 'Brillo' '%s%%'"
                                         display-brightness))))

(defun my/brightness-down ()
  "Disminuye el brillo de la pantalla usando brightnessctl y muestra una notificación."
  (interactive)
  ;; Ejecuta el comando para disminuir el brillo
  (start-process-shell-command "brightness-down" nil "brightnessctl set 5%-")
  ;; Obtiene el brillo actual y lo muestra en una notificación
  (let* ((current-brightness (shell-command-to-string "brightnessctl get | awk '{printf \"%d\", ($1 < 0 ? 0 : ($1 > 100 ? 100 : $1))}'"))
         (display-brightness (string-trim current-brightness)))
    (start-process-shell-command "notify-brightness-down" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness 'Brillo' '%s%%'"
                                         display-brightness))))
(defun my/volume-up ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%+")
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command "notify" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                         (string-trim volume)))))

(defun my/volume-down ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%-")
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command "notify" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                         (string-trim volume)))))

(defun my/volume-toggle-mute ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse set Master 1+ toggle")
  (let ((mute-status (shell-command-to-string "amixer -D pulse get Master | grep -o '\\[on\\]\\|\\[off\\]'")))
    (if (string-match "\\[off\\]" mute-status)
        (start-process-shell-command "notify" nil "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' 'Muted'")
      (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
        (start-process-shell-command "notify" nil
                                     (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                             (string-trim volume)))))))

(defun my/powermenu ()
  "Launch the power menu script."
  (interactive)
  (shell-command "~/.config/i3/scripts/powermenu &"))

;; NEW TODO
;; --- Switch back and forth between current and last workspace ---
(defvar my/last-exwm-workspace 0
  "Holds the index of the last visited EXWM workspace.")

(defun my/track-exwm-last-workspace ()
  "Track the last visited EXWM workspace."
  (unless (= exwm-workspace-current-index my/last-exwm-workspace)
    (setq my/last-exwm-workspace exwm-workspace-current-index)))

(add-hook 'exwm-workspace-switch-hook #'my/track-exwm-last-workspace)

(defvar my/previous-exwm-workspace nil
  "The previously visited EXWM workspace index.")

(defun my/exwm-switch-to-last-workspace ()
  "Toggle back to the previously visited EXWM workspace."
  (interactive)
  (when (and my/previous-exwm-workspace
             (numberp my/previous-exwm-workspace)
             (not (= exwm-workspace-current-index my/previous-exwm-workspace)))
    (let ((current exwm-workspace-current-index)
          (prev my/previous-exwm-workspace))
      (setq my/previous-exwm-workspace current)
      (exwm-workspace-switch prev))))

;; Track both current and previous workspaces
(add-hook 'exwm-workspace-switch-hook
          (lambda ()
            (setq my/previous-exwm-workspace my/last-exwm-workspace)
            (setq my/last-exwm-workspace exwm-workspace-current-index)))

(use-package exwm
  :config
  (setq exwm-workspace-number 6)
  (add-hook 'exwm-update-class-hook #'exwm/exwm-update-class)
  (add-hook 'exwm-init-hook #'exwm/exwm-init-hook)
  (add-hook 'exwm-manage-finish-hook #'exwm/configure-window-by-class)
  (require 'exwm-randr)
  (exwm-randr-mode t)
  (exwm/setup-displays)

  (require 'exwm-systemtray)
  (exwm-systemtray-mode 1)
  (setq exwm-systemtray-height 25)
  (setq exwm-layout-show-all-buffers t)
  (setq exwm-workspace-show-all-buffers t)
  ;; (setq display-time-day-and-date t)
  (display-time-mode 1)
  (setq exwm-manage-configurations
        '(((member exwm-class-name '("Telegram" "Google-chrome"))
	   char-mode t)))
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (setq
   exwm-input-simulation-keys '(([?\s-F] . [?\C-f]))
   exwm-input-prefix-keys
   '(?\C-x
     ?\C-u
     ?\C-h
     ?\M-x
     ?\M-`
     ?\M-&
     ?\M-:
     ?\C-\M-j
     ?\C-c
     ?\C-v
     ?\C-\ )
   exwm-input-global-keys
   `(
     ([?\s-r] . exwm-reset)
     ([s-left] . windmove-left)
     ([s-right] . windmove-right)
     ([s-up] . windmove-up)
     ([s-down] . windmove-down)

     ([?\s-q] . my/powermenu)

     ([?\s-d] . dired)
     ([s-p] . dmenu)
     ([s-return] . vterm)

     ;; QoL
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-b] . ibuffer)
     ([?\s-B] . kill-current-buffer)
     ([?\s-C] . +workspace/close-window-or-workspace)
     ;; SUPER+/ switches to char-mode (needed to pass commands in XWindows sometimes)
     ;; SUPER+? switches us back to line-mode
     ([?\s-/] . exwm-input-release-keyboard)
     ([?\s-?] . exwm-reset)
     ([?\s-m] . exwm-layout-toggle-mode-line)
     ;; change window focus with super+h,j,k,l
     ([?\s-h] evil-window-left)
     ([?\s-j] evil-window-next)
     ([?\s-k] evil-window-prev)
     ([?\s-l] evil-window-right)
     ;; ([?\s-`] exwm-workspace-switch-to-last)

     ;; move windows around using SUPER+SHIFT+h,j,k,l
     ([?\s-H] +evil/window-move-left)
     ([?\s-J] +evil/window-move-down)
     ([?\s-K] +evil/window-move-up)
     ([?\s-L] +evil/window-move-right)

     ([?\s-p] #'app-launcher-run-app)
     ([XF86AudioRaiseVolume] . my/volume-up)
     ([XF86AudioLowerVolume] . my/volume-down)
     ([XF86AudioMute]        . my/volume-toggle-mute)

     ([XF86MonBrightnessUp] . my/brightness-up)
     ([XF86MonBrightnessDown] . my/brightness-down)

     ([?\s-\C-h] side-bottom-window)
     ([?\s-\C-j] side-left-window)
     ([?\s-\C-l] side-right-window)

     ([?\s-\C-d] resize-window)
     ([?\s-\C-r] side-window-delete-all)

     ([?\s-z] . evil-window-split)
     ([?\s-v] . evil-window-vsplit)
     ([f11] . exwm-layout-toggle-fullscreen)

     ([?\s-&] . (lambda (command)
                  (interactive (list (read-shell-command "$ ")))
                  (start-process-shell-command command nil command)))

     ([?\s-`]   . my/exwm-switch-to-last-workspace)
     ([?\s-t] . (lambda ()
                  (interactive)
                  (start-process "" nil "kitty")))
     ([?\s-f] . (lambda ()
                  (interactive)
                  (start-process "" nil "google-chrome-stable")))

     ([?\s-n] . (lambda () (interactive) (start-process "" nil "thunar")))

     ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
     ,@(mapcar (lambda (i)
                 `(,(kbd (format "s-%d" i)) .
                   (lambda ()
                     (interactive)
                     (exwm-workspace-switch-create ,i))))
               (number-sequence 0 9))))

  (setq window-divider-default-right-width 1)
  (window-divider-mode 1)
  (exwm-wm-mode))


(setq mouse-autoselect-window t)
(setq focus-follows-mouse t)
(setq exwm-workspace-warp-cursor t)
(set-frame-parameter nil 'alpha-background 92)
(add-to-list 'default-frame-alist '(alpha-background . 92))
