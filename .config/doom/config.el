;; -*- lexical-binding: t -*-
(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrains Mono" :size 18 :weight 'Medium)
 doom-big-font (font-spec :family "JetBrains Mono" :size 36 :weight 'Bold)
 ;; doom-fallback-buffer-name "*dashboard*"
 ;; initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
 ;; doom-theme 'doom-one
 ;; doom-theme 'doom-solarized-light
 doom-theme 'doom-solarized-dark-high-contrast
 ;; doom-theme 'doom-solarized-dark
 ;; doom-theme 'ef-dark
 ;; doom-theme 'doom-flatwhite
 +latex-viewers '(pdf-tools)
 use-package-compute-statistics t
 auto-save-default t
 so-long-minor-mode t
 which-key-idle-delay 0.3
 history-length 20
 savehist-mode 1
 vterm-always-compile-module t
 initial-major-mode (quote fundamental-mode)
 display-line-numbers-type 'relative)
(define-key evil-normal-state-map (kbd "-") 'dired-jump)
(advice-add #'add-node-modules-path :override #'ignore)
(advice-add 'jsonrpc--log-event :override #'ignore)
;; (add-hook 'window-setup-hook #'toggle-frame-fullscreen)
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)

(load! "configs/+modeline")
(load! "configs/+which-key")
(load! "configs/+evilmode")
(load! "configs/+company")
(load! "configs/+magit")
(load! "configs/+vterm")
(load! "configs/+treesitter")
(load! "configs/+org")
(load! "configs/+eglot")
(load! "configs/+dashboard")
(load! "configs/+persp")
(load! "configs/+keybindings")
(load! "configs/+latex")
(load! "configs/+utility")
(load! "configs/+projectile")
;; (load! "configs/ghcid")
