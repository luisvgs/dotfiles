;; (after! magit
;;   (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

;;   (defun my-magit-display-buffer (buffer)
;;     "Displays the magit BUFFER in a vertical split."
;;     (display-buffer
;;      buffer (if (and (derived-mode-p 'magit-mode)
;;                      (memq (with-current-buffer buffer major-mode)
;;                            '(magit-process-mode
;;                              magit-revision-mode
;;                              magit-diff-mode
;;                              magit-status-mode)))
;;                 '(display-buffer-same-window)
;;               nil)))
;;   (setq magit-display-buffer-function #'my-magit-display-buffer))
