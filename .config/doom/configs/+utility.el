(defun my-kill-process ()
  (interactive)
  (let* ((processes
          (cl-remove-if-not
           (lambda (name)
             (and (stringp name)
                  (not (string-match-p "root" name))
                  (string-match-p
                   (user-login-name) name)))
           (split-string
            (shell-command-to-string "ps -aux") "\n" t)))
         (process (completing-read "Kill: " processes nil t)))
    (shell-command-to-string (concat "kill -9 " (nth 1 (split-string process))))))
