(setq org-directory "~/org/")
(setq todo-file "~/org/todo.org"
      org-agenda-files '("~/org"))
(setq org-agenda-files (list org-directory))

(after! org-mode
  (map! :map evil-org-mode-map
        :localleader
        :desc "Create/Edit Todo" "o" #'org-todo
        :desc "Schedule" "s" #'org-schedule
        :desc "Deadline" "d" #'org-deadline
        :desc "Refile" "r" #'org-refile
        :desc "Filter" "f" #'org-match-sparse-tree
        :desc "Tag heading" "t" #'org-set-tags-command)
  (setq org-bullets-bullet-list '("#")))
