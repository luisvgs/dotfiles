(defconst PROJECT_ROOT "~/programming/")
(defun haskell-new-project (project-name)
  (interactive "sProject name: ")
  (let* ((projects-dir PROJECT_ROOT)
         (project-path (concat projects-dir project-name "/")))

    (make-directory project-path t)

    (cd project-path)
    (let ((exit-code (shell-command "cabal init")))
      (if (= exit-code 0)
          (progn
            (message "Everything OK.")
            (projectile-add-known-project project-path)
            (message "Cabal init failed with exit code %d" exit-code)))))

  (global-set-key (kbd "C-c n h") 'haskell-new-project)
