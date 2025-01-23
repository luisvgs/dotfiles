;; -*- lexical-binding: t -*-
(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 19 :weight 'Regular)
 doom-theme 'grandshell
 +latex-viewers '(pdf-tools)
 use-package-compute-statistics t
 auto-save-default t
 so-long-minor-mode t
 which-key-idle-delay 0.3
 history-length 20
 savehist-mode 1
 vterm-always-compile-module t
 smerge-command-prefix "\C-cv"
 initial-major-mode (quote fundamental-mode)
 display-line-numbers-type 'relative)
(define-key evil-normal-state-map (kbd "-") 'dired-jump)
(advice-add #'add-node-modules-path :override #'ignore)
(advice-add 'jsonrpc--log-event :override #'ignore)
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)

(use-package! pdf-tools
  :defer t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

(after! vertico
  (setq vertico-count 12))

(use-package! rainbow-mode
  :hook (org-mode . rainbow-mode))

(defun isearch-forward-region-cleanup ()
  "turn off variable, widen"
  (if isearch-forward-region
      (widen))
  (setq isearch-forward-region nil))

(defvar isearch-forward-region nil
  "variable used to indicate we're in region search")

(add-hook 'isearch-mode-end-hook 'isearch-forward-region-cleanup)

(defun isearch-forward-region (&optional regexp-p no-recursive-edit)
  "Do an isearch-forward, but narrow to region first."
  (interactive "P\np")
  (narrow-to-region (point) (mark))
  (goto-char (point-min))
  (setq isearch-forward-region t)
  (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))

(global-set-key (kbd "C-c s") 'isearch-forward-region)

(defun my-align-single-equals ()
  "Align on a single equals sign (with a space either side)."
  (interactive)
  (align-regexp
   (region-beginning) (region-end)
   "\\(\\s-*\\) = " 1 0 nil))

(global-set-key (kbd "C-c C-a") 'my-align-single-equals)


(use-package! centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (setq centaur-tabs-style "box"
        centaur-tabs-height 37
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button nil
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons nil
        centaur-tabs-set-bar 'under
        centaur-tabs-show-count nil
        x-underline-at-descent-line t
        centaur-tabs-left-edge-margin nil)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right)
  (:map evil-normal-state-map
        ;; TODO: mappings for forward/backward-group
        ("C-l" . centaur-tabs-forward)
        ("C-h" . centaur-tabs-backward))
  )

(setq read-process-output-max (* 10 1024 1024)) ;; 10mb
(setq gc-cons-threshold 200000000)

;; (setq spacious-padding-widths
;;       '( :internal-border-width 10
;;          :header-line-width 4
;;          :mode-line-width 4
;;          :tab-width 4
;;          :right-divider-width 30
;;          :scroll-bar-width 8
;;          :fringe-width 10))

;; (spacious-padding-mode 1)





(load! "configs/+modeline")
(load! "configs/+which-key")
(load! "configs/+evilmode")
(load! "configs/+company")
(load! "configs/+magit")
(load! "configs/+vterm")
(load! "configs/+treesitter")
(load! "configs/+org")
(load! "configs/+eglot")
;; (load! "configs/+lsp")
(load! "configs/+persp")
(load! "configs/+keybindings")
(load! "configs/+latex")
(load! "configs/+utility")
(load! "configs/+projectile")
;; (load! "configs/+init-scala")
(load! "configs/+dashboard")
;; (load! "configs/+avy")
;; (load! "configs/ghcid")
;; (load! "configs/+m4ue")

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

  (defvar exwm-workspace--switch-history-hack (cons exwm-workspace-current-index '()))

  (add-hook 'exwm-workspace-switch-hook
            (lambda ()
              (setq exwm-workspace--switch-history-hack
                    (cons exwm-workspace-current-index
                          (car exwm-workspace--switch-history-hack)))))

  (defun exwm-workspace-switch-to-last ()
    (interactive)
    "Switch to the workspace that was used before current workspace"
    (exwm-workspace-switch (cdr exwm-workspace--switch-history-hack)))

  (use-package exwm
    :config
    (setq exwm-workspace-number 6)
    ;; When window "class" updates, use it to set the buffer name
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

       ;; QoL
       ([s-return] . vterm)
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
