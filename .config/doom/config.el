;; -*- lexical-binding: t -*-
(use-package! doom)
(setq
 user-full-name "Luis Vegas"
 user-mail-address "luisvegasmor@gmail.com"
 doom-font (font-spec :family "JetBrains Mono" :size 18 :weight 'Medium)
 ;; doom-font (font-spec :family "Terminus" :size 18 :weight 'Medium)
 ;; doom-font (font-spec :family "Iosevka Term" :size 20 :weight 'Medium)
 doom-big-font (font-spec :family "JetBrains Mono" :size 36 :weight 'Bold)
 doom-theme 'modus-operandi
 ;; doom-theme 'doom-solarized-dark-high-contrast
 +latex-viewers '(pdf-tools)
 use-package-compute-statistics t
 auto-save-default t
 so-long-minor-mode t
 which-key-idle-delay 0.3
 history-length 20
 savehist-mode 1

 vterm-always-compile-module t
 smerge-command-prefix "\C-cv"
 ;; initial-major-mode (quote fundamental-mode)
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

(after! ivy
  (setq-default ivy-fixed-height-minibuffer t
                ivy-height 12)
  (map! :g "C-s" #'swiper-isearch))

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

;;  Elisp language stuff
;; (use-package! lispyville
;;   :init
;;   (general-add-hook '(emacs-lisp-mode-hook lisp-mode-hook) #'lispyville-mode)
;;   :config
;;   (lispyville-set-key-theme '(operators c-w additional)))

;; (use-package! lispy
;;   :mode ("\\.el\\'" . emacs-lisp-mode))

(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)



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
