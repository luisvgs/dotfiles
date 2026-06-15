;; TODO
;; Handle shutdown and reboot keybindings
;; Setup polybar like this guy: https://github.com/martinbaillie/dotfiles/blob/7da368f5b45fa64dd3de77ecca3dcf38f647c00a/config/emacs/%2Bexwm.el#L17

(defun exwm/shutdown ()
  (interactive)
  (if (y-or-n-p "Are you sure you want to shutdown?")
      (async-shell-command "shutdown now")
    (message "Shutdown aborted")
    ))

(defun exwm/reboot ()
  (interactive)
  (if (y-or-n-p "Are you sure you want to reboot?")
      (async-shell-command "reboot")
    (message "Reboot aborted")))

(defvar notify-id nil)
(defun exwm/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'exwm/display-startup-time)

(defvar exwm/polybar-process nil)
(defun exwm/kill-polybar ()
  (when exwm/polybar-process
    (ignore-errors (kill-process exwm/polybar-process)))
  (setq exwm/polybar-process nil))

(defun exwm/polybar-exwm-workspaces ()
  (mapconcat
   (lambda (i)
     (if (= i exwm-workspace-current-index)
         (format "%%{F#C678DD}[%d]%%{F-}" i)
       ;; (format "%%{F#5B6268} [%d] %%{F-}" i)))
       (format " %d " i)))
   (number-sequence 0 (1- exwm-workspace-number))
   ""))

(defun exwm/start-polybar ()
  (interactive)
  (exwm/kill-polybar)
  (setq exwm/polybar-process
        (start-process-shell-command "polybar" nil "polybar main")))

(defun exwm/send-polybar-hook (module hook-index)
  (start-process-shell-command "polybar-msg" nil
                               (format "polybar-msg hook %s %s" module hook-index)))

(defun exwm/polybar-update-workspace ()
  (exwm/send-polybar-hook "exwm-workspace" 1))

(add-hook 'exwm-workspace-switch-hook #'exwm/polybar-update-workspace)

(use-package! exwm-modeline
  :after exwm)

(after! exwm
  (require 'notifications))

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
  (start-process-shell-command "redshift" nil "redshift -O 4200")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (start-process "xkbmap" nil "setxkbmap" "us" "-variant" "altgr-intl")
  ;; (exwm/start-polybar)
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


(defun exwm/close-window-or-buffer ()
  (interactive)
  (cond
   ((derived-mode-p 'exwm-mode)
    (exwm-input-send-key (kbd "C-q")))
   ((> (length (window-list)) 1)
    (delete-window))
   (t
    (kill-buffer))))

(defun exwm/kill-current-window ()
  (interactive)
  (if (derived-mode-p 'exwm-mode)
      (exwm-manage--kill-buffer-and-window)
    (kill-current-buffer)))

(defun exwm/brightness-up ()
  (interactive)
  (start-process-shell-command "brightness-up" nil "brightnessctl set +5%")
  (let* ((current-brightness (shell-command-to-string "brightnessctl get | awk '{printf \"%d\", ($1 > 100 ? 100 : $1)}'"))
         (display-brightness (string-trim current-brightness)))
    (start-process-shell-command "notify-brightness-up" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness 'Brillo' '%s%%'"
                                         display-brightness))))

(defun exwm/brightness-down ()
  (interactive)
  (start-process-shell-command "brightness-down" nil "brightnessctl set 5%-")
  (let* ((current-brightness (shell-command-to-string "brightnessctl get | awk '{printf \"%d\", ($1 < 0 ? 0 : ($1 > 100 ? 100 : $1))}'"))
         (display-brightness (string-trim current-brightness)))
    (start-process-shell-command "notify-brightness-down" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:brightness 'Brillo' '%s%%'"
                                         display-brightness))))
(defun exwm/volume-up ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%+")
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (setq notify-id (notifications-notify :title "EXWM"
                                          :replaces-id notify-id
                                          :body (format "Volume: %s" (string-trim volume))))))

(defun exwm/volume-down ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%-")
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (setq notify-id (notifications-notify :title "EXWM"
                                          :replaces-id notify-id
                                          :body (format "Volume: %s" (string-trim volume))))))

(defun exwm/volume-toggle-mute ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse set Master 1+ toggle")
  (let ((mute-status (shell-command-to-string "amixer -D pulse get Master | grep -o '\\[on\\]\\|\\[off\\]'")))
    (if (string-match "\\[off\\]" mute-status)
        (start-process-shell-command "notify" nil "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' 'Muted'")
      (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
        (setq notify-id (notifications-notify :title "EXWM"
                                              :replaces-id notify-id
                                              :body (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                                            (string-trim volume))))))))

(defun exwm/powermenu ()
  "Launch the power menu script."
  (interactive)
  (shell-command "~/.config/i3/scripts/powermenu &"))

;; Switch back and forth between current and last workspace
(defvar exwm/last-exwm-workspace 0
  "Holds the index of the last visited EXWM workspace.")

(defun exwm/track-exwm-last-workspace ()
  "Track the last visited EXWM workspace."
  (unless (= exwm-workspace-current-index exwm/last-exwm-workspace)
    (setq exwm/last-exwm-workspace exwm-workspace-current-index)))

(add-hook 'exwm-workspace-switch-hook #'exwm/track-exwm-last-workspace)

(defvar exwm/previous-exwm-workspace nil
  "The previously visited EXWM workspace index.")

(defun exwm/exwm-switch-to-last-workspace ()
  "Toggle back to the previously visited EXWM workspace."
  (interactive)
  (when (and exwm/previous-exwm-workspace
             (numberp exwm/previous-exwm-workspace)
             (not (= exwm-workspace-current-index exwm/previous-exwm-workspace)))
    (let ((current exwm-workspace-current-index)
          (prev exwm/previous-exwm-workspace))
      (setq exwm/previous-exwm-workspace current)
      (exwm-workspace-switch prev))))

(add-hook 'exwm-workspace-switch-hook
          (lambda ()
            (setq exwm/previous-exwm-workspace exwm/last-exwm-workspace)
            (setq exwm/last-exwm-workspace exwm-workspace-current-index)))

(use-package exwm
  :config
  (setq exwm-workspace-number 6)
  (add-hook 'exwm-update-class-hook #'exwm/exwm-update-class)
  (add-hook 'exwm-init-hook #'exwm/exwm-init-hook)
  (add-hook 'exwm-init-hook #'exwm-modeline-mode)
  (add-hook 'exwm-manage-finish-hook #'exwm/configure-window-by-class)
  (require 'exwm-randr)
  (exwm-randr-mode t)
  (exwm/setup-displays)

  (require 'exwm-systemtray)
  (exwm-systemtray-mode 1)
  (setq exwm-systemtray-height 30)
  (setq exwm-layout-show-all-buffers t)
  (setq exwm-workspace-show-all-buffers t)
  ;; (add-hook 'exwm-floating-setup-hook #'exwm-layout-hide-mode-line)
  ;; (add-hook 'exwm-floating-exit-hook #'exwm-layout-show-mode-line)

  (setq exwm-manage-configurations
        '(((member exwm-class-name '("Telegram" "Google-chrome" "Zotero"))
	   char-mode t)))

  (defun exwm/auto-char-mode ()
    (when (and (derived-mode-p 'exwm-mode)
               (member exwm-class-name '("Telegram" "Google-chrome" "Zotero")))
      (run-with-idle-timer 0.3 nil
                           (lambda (buf)
                             (when (buffer-live-p buf)
                               (with-current-buffer buf
                                 (exwm-input-release-keyboard))))
                           (current-buffer))))

  (defun exwm/char-mode-on-workspace-switch ()
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (and (derived-mode-p 'exwm-mode)
                   (member exwm-class-name '("Telegram" "Google-chrome" "Zotero"))
                   (get-buffer-window buf (selected-frame)))
          (run-with-idle-timer 0.3 nil
                               (lambda (b)
                                 (when (buffer-live-p b)
                                   (with-current-buffer b
                                     (exwm-input-release-keyboard))))
                               buf)))))

  (add-hook 'exwm-manage-finish-hook #'exwm/auto-char-mode)
  (add-hook 'exwm-workspace-switch-hook #'exwm/char-mode-on-workspace-switch)

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

     ;; ([?\s-q] . exwm/shutdown)

     ([?\s-d] . dired)
     ([s-p] . dmenu)
     ([s-return] . vterm)

     ;; QoL
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-b] . ibuffer)
     ([?\s-q] . kill-current-buffer)
     ;; ([?\s-C] . +workspace/close-window-or-workspace)
     ([?\s-C] . exwm/close-window-or-buffer)
     ;; SUPER+/ switches to char-mode (needed to pass commands in XWindows sometimes)
     ;; SUPER+? switches us back to line-mode
     ([?\s-/] . exwm-input-release-keyboard)
     ([?\s-?] . exwm-reset)
     ([?\s-p] . app-launcher-run-app)
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

     ([XF86AudioRaiseVolume] . exwm/volume-up)
     ([XF86AudioLowerVolume] . exwm/volume-down)
     ([XF86AudioMute]        . exwm/volume-toggle-mute)

     ([XF86MonBrightnessUp] . exwm/brightness-up)
     ([XF86MonBrightnessDown] . exwm/brightness-down)

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

     ([?\s-`]   . exwm/exwm-switch-to-last-workspace)
     ([?\s-t] . (lambda ()
                  (interactive)
                  (start-process "" nil "kitty")))
     ([?\s-f] . (lambda ()
                  (interactive)
                  (start-process "" nil "google-chrome-stable")))

     ([?\s-n] . (lambda () (interactive) (start-process "" nil "thunar")))
     ;; (exwm-input-set-key (kbd "S-s-SPC") #'transpose-frame)
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

(defun exwm/after-reload-notify ()
  (setq notify-id (notifications-notify :title "EXWM"
                                        :replaces-id notify-id
                                        :body "System successfully compiled.")))
(defun exwm/before-reload-notify ()
  (setq notify-id (notifications-notify :title "EXWM"
                                        :replaces-id notify-id
                                        :body "Compiling..")))

(add-hook 'doom-after-reload-hook #'exwm/after-reload-notify)
(add-hook 'doom-before-reload-hook #'exwm/before-reload-notify)
