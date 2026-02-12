;; -*- lexical-binding: t -*-
;; TODO
;; ** Organize modules
;; Deactivate unneeded packages
(use-package! doom)
(let ((gem-bin-path "/home/luis/.local/share/gem/ruby/3.4.0/bin"))
  (setenv "PATH" (concat gem-bin-path ":" (getenv "PATH")))
  (add-to-list 'exec-path gem-bin-path))
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 ;; doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 19 :weight 'Regular)
 doom-theme 'doom-feather-dark
 native-comp-jit-compilation nil
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
(define-key evil-normal-state-map (kbd "-") 'dirvish)
(advice-add #'add-node-modules-path :override #'ignore)
(advice-add 'jsonrpc--log-event :override #'ignore)

(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)
(set-face-attribute 'default nil :font "Iosevka Comfy" :height 150 :weight 'regular)
(use-package! nyan-mode
  :config
  (setq nyan-animate-nyancat t)
  (nyan-mode 1))

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

(setq read-process-output-max (* 10 1024 1024))
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

(use-package! marginalia
  :bind ( ("M-A" . #'marginalia-cycle) )
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'center))

(after! vertico
  (setq vertico-count 10
        vertico-buffer-display-action '(display-buffer-reuse-window)
        vertico-grid-separator "       "
        vertico-grid-lookahead 50
        vertico-resize nil))

(rg-enable-default-bindings)

(use-package! evil-goggles
  :config
  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(setq evil-goggles-duration 0.400)


(defun my/treemacs-open-in-vterm ()
  "Open `vterm` in the Treemacs selected directory."
  (interactive)
  (let ((path (treemacs--prop-at-point :path)))
    (when path
      (let ((dir (if (file-directory-p path)
                     path
                   (file-name-directory path))))
        (let ((default-directory dir))
          (vterm))))))

(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "C-c C-t") #'my/treemacs-open-in-vterm))

;; (use-package! minions
;;   :hook (after-init . minions-mode))

(use-package! auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

;; (load! "configs/+exwm")
(load! "configs/+which-key")
(load! "configs/+evilmode")
(load! "configs/+company")
(load! "configs/+modeline")
(load! "configs/+magit")
(load! "configs/+vterm")
(load! "configs/+treesitter")
(load! "configs/+org")
(load! "configs/+eglot")
(load! "configs/+persp")
(load! "configs/+keybindings")
(load! "configs/+utility")
(load! "configs/+projectile")
;; (load! "configs/+dashboard")
;; (load! "configs/+latex")
(add-to-list 'load-path "~/.dotfiles/.config/doom/local")
