;; -*- lexical-binding: t -*-
;; TODO
;; ** Organize modules
;; Deactivate unneeded packages

(setq compile-angel-verbose t)
(compile-angel-on-load-mode)
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
 display-time-mode nil
 so-long-minor-mode t
 which-key-idle-delay 0.3
 history-length 20
 savehist-mode 1
 vterm-always-compile-module t
 smerge-command-prefix "\C-cv"
 initial-major-mode (quote fundamental-mode)
 display-line-numbers-type 'relative)
(define-key evil-normal-state-map (kbd "-") 'dirvish-fd)
(advice-add #'add-node-modules-path :override #'ignore)
(advice-add 'jsonrpc--log-event :override #'ignore)

(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)
(set-face-attribute 'default nil :font "Iosevka Comfy" :height 150 :weight 'Regular)

(use-package! nyan-mode
  :disabled t
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

;; (use-package! marginalia
;;   :bind ( ("M-A" . #'marginalia-cycle) )
;;   :custom
;;   (marginalia-max-relative-age 0)
;;   (marginalia-align 'center))

;; (after! vertico
;;   (setq vertico-count 10
;;         vertico-buffer-display-action '(display-buffer-reuse-window)
;;         vertico-grid-separator "       "
;;         vertico-grid-lookahead 50
;;         vertico-resize nil))

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

(use-package! auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))



(use-package! ivy
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-initial-inputs-alist nil
        ivy-wrap t
        ivy-height 10
        ivy-use-selectable-prompt t
        ivy-re-builders-alist '((counsel-rg . ivy--regex-plus)
                                (counsel-git-grep . ivy--regex-plus)
                                (swiper . ivy--regex-plus) (t . ivy--regex-fuzzy)))
  :bind (:map ivy-minibuffer-map
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line)
              ("C-d" . ivy-scroll-up-command)
              ("C-u" . ivy-scroll-down-command)
              ("C-RET" . ivy-immediate-done)
              ("C-SPC" . ivy-restrict-to-matches)))

(use-package! counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-switch-buffer)
  ("C-x C-f" . counsel-find-file)
  ("C-x C-r" . counsel-recentf)
  ("C-c g" . counsel-git)
  ("C-c j" . counsel-git-grep)
  ("C-c s" . counsel-rg)
  ("C-h f" . counsel-describe-function)
  ("C-h v" . counsel-describe-variable)
  ("C-h l" . counsel-find-library)
  ("C-h a" . counsel-apropos)
  :config
  (setq counsel-find-file-ignore-regexp (concat "\\(?:^[#.]\\)" "\\|\\(?:[#~]$\\)" "\\|\\(?:^Icon?\\)" "\\|\\.elc$" "\\|\\.o$"))
  (setq counsel-rg-base-command "rg --with-filename --no-heading --line-number --color never --smart-case %s"))

(use-package! swiper
  :bind
  ("C-s" . swiper-isearch)
  ("C-r" . swiper-isearch-backward)
  :config (setq swiper-action-recenter t
                swiper-goto-start-of-match t))

(use-package! ivy-rich
  :after ivy
  :config
  (setq ivy-rich-path-style 'abbrev)
  (ivy-rich-mode t)
  (ivy-rich-project-root-cache-mode t))

(use-package! nerd-icons-ivy-rich
  :after ivy-rich
  :config (nerd-icons-ivy-rich-mode t))

(use-package! ivy-prescient
  :after counsel
  :config
  (setq ivy-prescient-retain-classic-highlighting t
        prescient-sort-full-matches-first t
        prescient-filter-method '(literal regexp initialism fuzzy))
  (ivy-prescient-mode t)
  (prescient-persist-mode t))


(add-to-list 'load-path "~/.emacs.d/site-lisp/qutebrowser.el")
(require 'qutebrowser)

(load! "configs/+exwm")
(load! "configs/+dashboard.el")
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
(load! "configs/+consult")
(add-to-list 'load-path "~/dotfiles/.config/doom/local")
(add-to-list 'custom-theme-load-path "~/dotfiles/.config/doom/local/color-theme-ujelly/")
;; (load! "configs/+m4ue")
