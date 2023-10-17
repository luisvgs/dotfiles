(after! org-mode
  org-directory "~/org/"
  todo-file "~/org/todo.org"
  org-agenda-files '("~/org")
  (setq org-bullets-bullet-list '("#")))

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode))

(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode))
