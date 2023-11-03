(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'SemiBold)
 ;; doom-theme 'ef-dark
 ;; doom-theme 'doom-solarized-dark-high-contrast
 doom-theme 'doom-solarized-light
 ;; doom-theme 'modus-vivendi-deuteranopia
 ;; doom-theme 'doom-one
 ;; doom-theme 'doom-vibrant
 ;; doom-theme 'doom-zenburn
 ;; doom-theme 'doom-tomorrow-night
 ;; doom-theme 'ef-winter
 ;; doom-theme 'doom-wilmersdorf
 ;; doom-theme 'doom-flatwhite
 use-package-compute-statistics t
 auto-save-default t
 so-long-minor-mode t
 which-key-idle-delay 0.3
 vterm-always-compile-module t
 initial-major-mode (quote fundamental-mode)
 display-line-numbers-type 'relative)


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
;; (load! "configs/+lsp")
