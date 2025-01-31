;; -*- lexical-binding: t -*-
;; TODO
;; ** Organize modules
;; Deactivate unneeded packages


(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 19 :weight 'Regular)
 doom-theme 'doom-one
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
  (centaur-tabs-mode nil)
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 40
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button nil
        centaur-tabs-set-close-button nil
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons nil
        centaur-tabs-set-bar 'left
        centaur-tabs-show-count nil
        x-underline-at-descent-line t
        centaur-tabs-left-edge-margin nil)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
  (centaur-tabs-headline-match)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
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
        ("C-l" . centaur-tabs-forward)
        ("C-h" . centaur-tabs-backward))
  )

(setq read-process-output-max (* 10 1024 1024)) ;; 10mb
(setq gc-cons-threshold 200000000)


(use-package! consult
  :bind (
         ("M-y" . consult-yank-from-kill-ring)))

(use-package! drag-stuff
  :defer t
  :init
  (drag-stuff-mode)
  :config
  (map! :map evil-normal-state-map
        "M-j" #'drag-stuff-down
        "M-k" #'drag-stuff-up))

(use-package! dired-preview
  :hook dired-mode
  :config
  (setq dired-preview-delay 0.5)
  (setq dired-preview-max-size (expt 2 20))
  (setq dired-preview-ignored-extensions-regexp
        (concat "\\."
                "\\(gz\\|"
                "zst\\|"
                "tar\\|"
                "xz\\|"
                "rar\\|"
                "zip\\|"
                "iso\\|"
                "epub"
                "\\)"))
  (dired-preview-global-mode 1))

(use-package! marginalia
  :bind ( ("M-A" . #'marginalia-cycle) )
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'center))

(after! vertico
  (vertico-multiform-mode)
  (require 'vertico-buffer)
  (require 'vertico-multiform)

  (setq vertico-multiform-commands
        '((consult-line grid reverse)
          (consult-grep buffer)
          (consult-ripgrep buffer)
          (helpful-variable reverse)
          (consult-buffer reverse)
          (dmenu flat)
          (file reverse)
          (execute-extended-command reverse)))

  (setq vertico-count 10
        vertico-buffer-display-action '(display-buffer-reuse-window)
        vertico-grid-separator "       "
        vertico-grid-lookahead 50
        vertico-resize t)

  (setq vertico-multiform-categories
        '((file reverse)
          (imenu (:not indexed mouse))
          (symbol (vertico-sort-function . vertico-sort-alpha))))

  (map! :map vertico-map
        "M-B" #'vertico-multiform-buffer
        "M-G" #'vertico-multiform-grid
        "M-F" #'vertico-multiform-flat
        "M-R" #'vertico-multiform-reverse
        "M-V" #'vertico-multiform-vertical)

  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "» " 'face 'vertico-current)
                   "  ")
                 cand))))

(load! "configs/+modeline")
(load! "configs/+which-key")
(load! "configs/+evilmode")
(load! "configs/+company")
(load! "configs/+magit")
(load! "configs/+vterm")
(load! "configs/+treesitter")
(load! "configs/+org")
(load! "configs/+eglot")
(load! "configs/+persp")
(load! "configs/+keybindings")
(load! "configs/+latex")
(load! "configs/+utility")
(load! "configs/+projectile")
(load! "configs/+dashboard")
;; (load! "configs/+init-scala")
;; (load! "configs/+avy")

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
