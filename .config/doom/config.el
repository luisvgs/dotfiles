(setq user-full-name "Luis Vegas"
      user-mail-address "luisvegasmor@gmail.com")

(use-package! doom)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'SemiBold)
      doom-theme 'ef-dark
      ;; doom-theme 'doom-solarized-dark-high-contrast
      ;; doom-theme 'modus-vivendi-deuteranopia
      ;; doom-theme 'doom-one
      ;; doom-theme 'doom-zenburn
      ;; doom-theme 'doom-tomorrow-night
      ;; doom-theme 'ef-winter
      ;; doom-theme 'doom-wilmersdorf
      use-package-compute-statistics t
                                        ; display-battery-mode t
      so-long-minor-mode t
      which-key-idle-delay 0.3
      vterm-always-compile-module t
      initial-major-mode (quote fundamental-mode)
      display-line-numbers-type 'relative)

;; (add-hook 'window-setup-hook #'toggle-frame-fullscreen)
                                        ; (fset 'battery-update #'ignore)

(advice-add #'add-node-modules-path :override #'ignore)

;; (setq +ivy-buffer-preview t)
(global-set-key (kbd "C-x C-b") 'ibuffer)
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
      "r g" #'+ivy/project-search)

(map! :g "C-z" #'undo)

(add-to-list 'image-types 'gif)
(use-package! latex-preview-pane-enable :after latex-mode :hook (latex-mode . lsp))

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
;; (load! "configs/+lsp")
