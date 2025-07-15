;; (use-package! doom-modeline
;;   :config
;;   (setq doom-modeline-height 40
;;         doom-modeline-unicode-fallback nil
;;         doom-modeline-icon t
;;         doom-plain-brighter-modeline nil
;;         doom-modeline-major-mode-icon t
;;         doom-modeline-major-mode-color-icon t
;;         doom-modeline-buffer-file-name-style 'auto
;;         doom-modeline-workspace-name nil
;;         doom-modeline-buffer-state-icon t
;;         doom-modeline-buffer-modification-icon t
;;         doom-modeline-buffer-name t
;;         doom-modeline-modal-modern-icon t
;;         doom-modeline-lsp-icon t
;;         doom-modeline-lsp t
;;         doom-modeline-modal-icon nil
;;         doom-modeline-modal t
;;         ;; doom-modeline-mu4e t
;;         doom-modeline-persp-icon t
;;         doom-modeline-persp-name t)
;;   (custom-set-faces!
;;     '(doom-modeline-buffer-modified :foreground "orange")))



(setq-default mode-line-format
  '("%e"
     " %o "
     "%* "
     my-modeline-buffer-name
     my-modeline-major-mode
     my-modeline-git-branch))

(defvar-local my-modeline-buffer-name
  '(:eval
     (when (mode-line-window-selected-p)
       (propertize (format " %s " (buffer-name))
         'face '(t :background "#3355bb" :foreground "white" :inherit bold))))
  "Mode line construct to display the buffer name.")

(put 'my-modeline-buffer-name 'risky-local-variable t)

(defvar-local my-modeline-major-mode
  '(:eval
     (list
       (propertize "λ" 'face 'shadow)
       " "
       (propertize (capitalize (symbol-name major-mode)) 'face 'bold)))
  "Mode line construct to display the major mode.")

(put 'my-modeline-major-mode 'risky-local-variable t)


(defvar-local my-modeline-git-branch
  '(:eval
     (when (and (mode-line-window-selected-p)
                (vc-git-root default-directory))
       (let ((branch (vc-git--symbolic-ref default-directory)))
         (when branch
           (propertize (format " %s " branch)
             'face '(t :foreground "white" ))))))
  "Mode line construct to display the git branch.")
(put 'my-modeline-git-branch 'risky-local-variable t)
