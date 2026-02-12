;;; ============================================================
;;; Startup Timer
;;; ============================================================

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;;; ============================================================
;;; Workspace Count (MUST be before EXWM loads)
;;; ============================================================

(setq exwm-workspace-number 6)

;;; ============================================================
;;; Modeline + dmenu
;;; ============================================================

(use-package! exwm-modeline
  :after exwm)

(use-package! dmenu
  :after exwm)

(add-hook 'exwm-init-hook #'exwm-modeline-mode)

;;; ============================================================
;;; Display Configuration
;;; ============================================================

(defun exwm/setup-displays ()
  (let ((hdmi-connected
         (string-match-p
          "HDMI-2 connected"
          (shell-command-to-string "xrandr"))))
    (if hdmi-connected
        (start-process-shell-command
         "xrandr" nil
         "xrandr --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --off")
      (start-process-shell-command
       "xrandr" nil
       "xrandr --output eDP-1 --primary --auto --output HDMI-2 --off"))))

;;; ============================================================
;;; Wallpaper
;;; ============================================================

(defun exwm/set-wallpaper ()
  (interactive)
  (start-process-shell-command
   "feh" nil "feh --bg-fill ~/.config/wallpapers/space.png"))

;;; ============================================================
;;; EXWM Init Hook
;;; ============================================================

(defun exwm/exwm-init-hook ()
  (start-process-shell-command "redshift" nil "redshift -O 4300")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (exwm/set-wallpaper)
  (exwm-workspace-switch-create 1))

;;; ============================================================
;;; Workspace Tracking (FIXED)
;;; ============================================================

(defvar my/last-exwm-workspace 0)
(defvar my/previous-exwm-workspace nil)

(add-hook 'exwm-workspace-switch-hook
          (lambda ()
            (setq my/previous-exwm-workspace my/last-exwm-workspace)
            (setq my/last-exwm-workspace exwm-workspace-current-index)))

(defun my/exwm-switch-to-last-workspace ()
  (interactive)
  (when (and my/previous-exwm-workspace
             (not (= exwm-workspace-current-index
                     my/previous-exwm-workspace)))
    (let ((current exwm-workspace-current-index))
      (exwm-workspace-switch my/previous-exwm-workspace)
      (setq my/previous-exwm-workspace current))))

;;; ============================================================
;;; Rename Buffers by Class
;;; ============================================================

(defun exwm/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

;;; ============================================================
;;; Window Placement by Class
;;; ============================================================

(defun exwm/configure-window-by-class ()
  (pcase exwm-class-name
    ("slack"         (exwm-workspace-move-window 2))
    ("Telegram"      (exwm-workspace-move-window 3))
    ("Kitty"         (exwm-workspace-move-window 1))
    ("Thunar"        (exwm-workspace-move-window 4))
    ("Google-chrome" (exwm-workspace-move-window 2))))

;;; ============================================================
;;; Volume Controls
;;; ============================================================

(defun my/volume-up ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%+")
  (let ((volume (shell-command-to-string
                 "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command
     "notify" nil
     (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
             (string-trim volume)))))

(defun my/volume-down ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%-")
  (let ((volume (shell-command-to-string
                 "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command
     "notify" nil
     (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
             (string-trim volume)))))

(defun my/volume-toggle-mute ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse set Master 1+ toggle")
  (let ((mute-status (shell-command-to-string
                      "amixer -D pulse get Master | grep -o '\\[on\\]\\|\\[off\\]'")))
    (if (string-match "\\[off\\]" mute-status)
        (start-process-shell-command
         "notify" nil
         "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' 'Muted'")
      (my/volume-up))))

;;; ============================================================
;;; Brightness Controls
;;; ============================================================

(defun my/brightness-up ()
  (interactive)
  (start-process-shell-command "brightness-up" nil "brightnessctl set +5%")
  (let ((brightness
         (shell-command-to-string
          "brightnessctl info | grep -oP '\\(\\K[0-9]+(?=%\\))'")))
    (start-process-shell-command
     "notify-brightness" nil
     (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness 'Brightness' '%s%%'"
             (string-trim brightness)))))

(defun my/brightness-down ()
  (interactive)
  (start-process-shell-command "brightness-down" nil "brightnessctl set 5%-")
  (my/brightness-up))

;;; ============================================================
;;; Power Menu
;;; ============================================================

(defun my/powermenu ()
  (interactive)
  (shell-command "~/.config/i3/scripts/powermenu &"))

;;; ============================================================
;;; EXWM Main Configuration
;;; ============================================================

(use-package! exwm
  :config
  (exwm-wm-mode)

  ;; Hooks
  (add-hook 'exwm-update-class-hook #'exwm/exwm-update-class)
  (add-hook 'exwm-init-hook #'exwm/exwm-init-hook)
  (add-hook 'exwm-manage-finish-hook #'exwm/configure-window-by-class)

  ;; RandR
  (require 'exwm-randr)
  (exwm-randr-mode 1)
  (add-hook 'exwm-randr-screen-change-hook #'exwm/setup-displays)

  ;; System tray
  (require 'exwm-systemtray)
  (exwm-systemtray-mode 1)
  (setq exwm-systemtray-height 25)

  ;; General settings
  (setq exwm-layout-show-all-buffers t
        exwm-workspace-show-all-buffers t)

  ;; Global Keys
  (setq exwm-input-global-keys
        `(
          ([?\s-r] . exwm-reset)
          ([?\s-w] . exwm-workspace-switch)
          ([?\s-\t] . my/exwm-switch-to-last-workspace)
          ([?\s-q] . my/powermenu)

          ([s-return] . vterm)
          ([s-S-return] . dmenu)
          ([?\s-d] . dired)

          ([XF86AudioRaiseVolume] . my/volume-up)
          ([XF86AudioLowerVolume] . my/volume-down)
          ([XF86AudioMute]        . my/volume-toggle-mute)

          ([XF86MonBrightnessUp]   . my/brightness-up)
          ([XF86MonBrightnessDown] . my/brightness-down)

          ,@(mapcar
             (lambda (i)
               `(,(kbd (format "s-%d" i))
                 . (lambda ()
                     (interactive)
                     (exwm-workspace-switch-create ,i))))
             (number-sequence 0 5))))

  (window-divider-mode 1))

;;; ============================================================
;;; Mouse Behavior
;;; ============================================================

(setq mouse-autoselect-window t
      focus-follows-mouse t
      exwm-workspace-warp-cursor t)
