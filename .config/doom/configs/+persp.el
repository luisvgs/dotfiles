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
