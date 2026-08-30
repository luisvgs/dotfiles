(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"
        persp-add-buffer-on-find-file t
        persp-add-buffer-on-after-change-major-mode t)

  ;; (defun display-workspaces-in-minibuffer ()
  ;;   (with-current-buffer " *Minibuf-0*"
  ;;     (erase-buffer)
  ;;     (insert (+workspace--tabline))))
  ;; (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display)

  (defun my/persp-consult-buffer ()
    (interactive)
    (with-persp-buffer-list () (consult-buffer)))

  (map! :leader "," #'my/persp-consult-buffer))

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
