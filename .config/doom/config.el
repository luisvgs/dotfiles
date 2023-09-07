(setq user-full-name "Luis Vegas"
      user-mail-address "luisvegasmor@gmail.com")

(use-package! doom)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'Medium))
(setq doom-theme 'doom-one)
(setq ibuffer-show-empty-filter-groups nil)
(setq use-package-compute-statistics t)
(setq display-line-numbers-type 'relative)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq so-long-minor-mode t)
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


(use-package! latex-preview-pane-enable :after latex-mode :hook (latex-mode . lsp))
(load! "configs/doom-modeline")
(load! "configs/which-key")
(load! "configs/lsp")
(load! "configs/evilmode")
(load! "configs/company")
(load! "configs/magit")
(load! "configs/vterm")
(load! "configs/treesitter")
