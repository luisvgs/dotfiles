(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'Medium))
(setq doom-modeline-height 22)

(setq doom-theme 'doom-one)

(map! :leader
      :prefix "o"
      :desc "Open .dotfiles folder"
      :n "p" #'dired "$HOME/.dotfiles/.config")

(setq display-line-numbers-type 'relative)
(after! doom-modeline
  (setq doom-modeline-persp-name t))
(setq so-long-minor-mode t)
(setq initial-major-mode (quote fundamental-mode))
(setq org-directory "~/org/")

(use-package! which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(display-time-mode 1)                             ; Enable time in the mode-line

(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))                       ; it's nice to know how much power you have
(global-subword-mode 1)

(use-package! lsp-mode
  :hook
  (rustic-mode . lsp)
  (rust-mode . lsp)
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all nil)
  (lsp-inlay-hint-enable nil)
  (lsp-lens-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-rust-analyzer-server-display-inlay-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints nil)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints nil)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (setq eldoc-documentation-functions nil))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-peek-always-show nil)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable nil))

(use-package! highlight-indent-guides
  :config
  (setq highlight-indent-guides-auto-enabled t
        highlight-indent-guides-responsive nil
        highlight-indent-guides-method 'bitmap))

(use-package! magit
  :commands magit-status)
(use-package! vterm :commands vterm)

(use-package! company
  :after lsp-mode
  :diminish
  :hook (lsp-mode . company-mode))

(setq rustic-indent-offset 2)
(use-package! tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
