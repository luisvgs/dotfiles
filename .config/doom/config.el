(setq user-full-name "Luis Vegas"
      user-mail-address "luisvegasmor@gmail.com")

(use-package! doom)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'SemiBold)
      ;; doom-theme 'ef-dark
      ;; doom-theme 'doom-solarized-dark-high-contrast
      ;; doom-theme 'modus-vivendi-deuteranopia
      ;; doom-theme 'doom-one
      ;; doom-theme 'doom-vibrant
      ;; doom-theme 'doom-zenburn
      ;; doom-theme 'doom-tomorrow-night
      ;; doom-theme 'ef-winter
      ;; doom-theme 'doom-wilmersdorf
      doom-theme 'doom-flatwhite
      use-package-compute-statistics t
      auto-save-default t
      so-long-minor-mode t
      which-key-idle-delay 0.3
      vterm-always-compile-module t
      initial-major-mode (quote fundamental-mode)
      display-line-numbers-type 'relative)

;; (after! persp-mode
;;   ;; alternative, non-fancy version which only centers the output of +workspace--tabline
;;   (defun workspaces-formatted ()
;;     (+doom-dashboard--center (frame-width) (+workspace--tabline)))

;;   (defun hy/invisible-current-workspace ()
;;     "The tab bar doesn't update when only faces change (i.e. the
;; current workspace), so we invisibly print the current workspace
;; name as well to trigger updates"
;;     (propertize (safe-persp-name (get-current-persp)) 'invisible t))

;;   (customize-set-variable 'tab-bar-format '(workspaces-formatted tab-bar-format-align-right hy/invisible-current-workspace))

;;   ;; don't show current workspaces when we switch, since we always see them
;;   (advice-add #'+workspace/display :override #'ignore)
;;   ;; same for renaming and deleting (and saving, but oh well)
;;   (advice-add #'+workspace-message :override #'ignore))

;; ;; need to run this later for it to not break frame size for some reason
;; (run-at-time nil nil (cmd! (tab-bar-mode +1)))

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

;; (unless (equal "Battery status not available"
;;                (battery))
;;   (display-battery-mode 1))

(advice-add #'add-node-modules-path :override #'ignore)

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
;; (load! "configs/+treemacs")
(load! "configs/+utility")
(load! "configs/+keybindings")
(load! "configs/+latex")
;; (load! "configs/+lsp")
