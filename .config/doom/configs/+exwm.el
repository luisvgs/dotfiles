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
        ;; Si HDMI está conectado, úsalo como primario
        (start-process-shell-command
         "xrandr" nil
         "xrandr --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --off")
      ;; Si no, usa solo la pantalla del laptop
      (start-process-shell-command
       "xrandr" nil
       "xrandr --output eDP-1 --primary --auto --output HDMI-2 --off"))))

(defun running-in-exwm-p ()
  "Return t if the current session is running under EXWM."
  (and (eq window-system 'x)
       (string= (getenv "DESKTOP_SESSION") "exwm")))

(defun exwm/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(defun exwm/exwm-init-hook ()
  (start-process-shell-command "redshift" nil "redshift -O 4700")
  (exwm-workspace-switch-create 1))

(defun exwm/configure-window-by-class ()
  (interactive)
  (pcase exwm-class-name
    ("slack" (exwm-workspace-move-window 6))
    ("Telegram" (exwm-workspace-move-window 3))
    ("Kitty" (exwm-workspace-move-window 1))
    ("Thunar" (exwm-workspace-move-window 8))
    ("Google-chrome" (exwm-workspace-move-window 2))
    (_ nil))
  (exwm-layout-toggle-mode-line))


(defun my/close-window-or-buffer ()
  (interactive)
  (cond
   ((derived-mode-p 'exwm-mode)
    (exwm-input-send-key (kbd "C-q"))) ; Envía Alt+F4 a la aplicación
   ((> (length (window-list)) 1)
    (delete-window))
   (t
    (kill-buffer))))

(defun my/kill-current-window ()
  (interactive)
  (if (derived-mode-p 'exwm-mode)
      (exwm-manage--kill-buffer-and-window)
    (kill-current-buffer)))



;; (defvar my/last-workspace nil

;; (defun my/workspace-back-and-forth ()
;;   (interactive)
;;   (if my/last-workspace
;;       (let ((current-workspace exwm-workspace-current-index))
;;         (unless (= current-workspace my/last-workspace)
;;           (exwm-workspace-switch my/last-workspace)))
;;     (message "No previous workspace recorded")))

;; (defun my/track-workspace-changes ()
;;   (setq my/last-workspace exwm-workspace-current-index))

;; (add-hook 'exwm-workspace-switch-hook #'my/track-workspace-changes)

;; (defun my/exwm-workspace-switch-and-track (index)
;;   "Switch to workspace INDEX and track the change."
;;   (let ((current exwm-workspace-current-index))
;;     (unless (= current index)
;;       (setq my/last-workspace current)
;;       (exwm-workspace-switch index))))


(defun my/volume-up ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%+")
  ;; Obtener el volumen actual y mostrarlo
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command "notify" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                         (string-trim volume)))))

(defun my/volume-down ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse sset Master 5%-")
  ;; Obtener el volumen actual y mostrarlo
  (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
    (start-process-shell-command "notify" nil
                                 (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                         (string-trim volume)))))

(defun my/volume-toggle-mute ()
  (interactive)
  (start-process-shell-command "amixer" nil "amixer -D pulse set Master 1+ toggle")
  ;; Verificar si está muteado
  (let ((mute-status (shell-command-to-string "amixer -D pulse get Master | grep -o '\\[on\\]\\|\\[off\\]'")))
    (if (string-match "\\[off\\]" mute-status)
        (start-process-shell-command "notify" nil "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' 'Muted'")
      (let ((volume (shell-command-to-string "amixer -D pulse get Master | grep -oP '\\d+%' | head -1")))
        (start-process-shell-command "notify" nil
                                     (format "notify-send -t 2000 -h string:x-canonical-private-synchronous:volume 'Volume' '%s'"
                                             (string-trim volume)))))))

;; (defvar exwm-workspace--switch-history-hack (cons exwm-workspace-current-index '()))

;; (add-hook 'exwm-workspace-switch-hook
;;           (lambda ()
;;             (setq exwm-workspace--switch-history-hack
;;                   (cons exwm-workspace-current-index
;;                         (car exwm-workspace--switch-history-hack)))))

;; (defun exwm-workspace-switch-to-last ()
;;   (interactive)
;;   "Switch to the workspace that was used before current workspace"
;;   (exwm-workspace-switch (cdr exwm-workspace--switch-history-hack)))

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
  (setq exwm-systemtray-height 32)
  (exwm-systemtray-mode t)

  (setq exwm-layout-show-all-buffers t)
  (setq exwm-workspace-show-all-buffers t)
  (setq display-time-day-and-date t)
  (display-time-mode 1)
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

     ([?\s-\t] . my/workspace-back-and-forth)

     ([?\s-d] . dired)
     ([s-S-return] . dmenu)
     ([s-return] . vterm)

     ;; QoL
     ([?\s-B] . my/close-window-or-buffer)
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-C] . +workspace/close-window-or-workspace)

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

     ([XF86AudioRaiseVolume] . my/volume-up)
     ([XF86AudioLowerVolume] . my/volume-down)
     ([XF86AudioMute]        . my/volume-toggle-mute)

     ;; move window to far left or far right with SUPER+CTRL+h, L
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

     ([?\s-t] . (lambda ()
                  (interactive)
                  (start-process "" nil "kitty")))

     ([?\s-f] . (lambda ()
                  (interactive)
                  (start-process "" nil "google-chrome-stable")))

     ([s-S-n] . (lambda () (interactive) (start-process "" nil "thunar")))

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
