(setq user-full-name "Luis Vegas"
      user-mail-address "luisvegasmor@gmail.com")

(use-package! doom)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'SemiBold)
      ;; doom-theme 'doom-solarized-dark-high-contrast
      doom-theme 'doom-one
      use-package-compute-statistics t
      so-long-minor-mode t
      split-width-threshold 10
      display-line-numbers-type 'relative)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq initial-major-mode (quote fundamental-mode))
(setq-default
 delete-by-moving-to-trash t
 window-combination-resize t
 x-stretch-cursor t)

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main")
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(map! :leader
      :prefix "o"
      :desc "Open .dotfiles folder"
      :n "p" #'dired "$HOME/.dotfiles/.config")

(map! :leader
      :desc "Perform Rg search"
      "r g" #'counsel-rg)

;; (use-package! lean4-mode
;;   :commands (lean4-mode)
;;   :mode ("\\.lean\\'" . lean4-mode))

(use-package! latex-preview-pane-enable :after latex-mode :hook (latex-mode . lsp))
(load! "configs/doom-modeline")
(load! "configs/which-key")
(load! "configs/lsp")
(load! "configs/evilmode")
(load! "configs/company")
(load! "configs/magit")
(load! "configs/vterm")
(load! "configs/treesitter")
;; (load! "configs/eglot")
(add-to-list 'image-types 'gif)
