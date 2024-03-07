;; -*- lexical-binding: t -*-
(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrains Mono" :size 18 :weight 'Medium)
 doom-big-font (font-spec :family "JetBrains Mono" :size 36 :weight 'Bold)
 doom-theme 'doom-solarized-light
 ;; doom-theme 'modus-operandi
 ;; doom-theme 'spacemacs-light
 ;; doom-theme 'doom-flatwhite
 ;; doom-theme 'doom-one
 +latex-viewers '(pdf-tools)
 use-package-compute-statistics t
 auto-save-default t
 so-long-minor-mode t
 which-key-idle-delay 0.3
 history-length 20
 split-height-threshold 790
 savehist-mode 1
 ;; doom-fallback-buffer-name "*dashboard*"
 ;; initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
 vterm-always-compile-module t
 ;;;; ediff-window-setup-function 'ediff-setup-windows-plain
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

(unless (display-graphic-p)
  (corfu-terminal-mode +1))

;; Investigate why emacs is not finding pdf.el
(use-package! pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

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
