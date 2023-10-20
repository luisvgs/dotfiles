(use-package! org
  :defer t
  :mode ("\\.org\\'" . org-mode))

(after! org org-directory "~/org/")

(setq org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
      org-deadline-warning-days 0
      org-agenda-span 7
      org-agenda-start-day "-0d"
      org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
      org-log-done 'time)

(after! org-fancy-priorities
  (setq org-fancy-priorities-list '("[A]" "[B]" "[C]")
        org-priority-faces
        '((?A :foreground "#ff6c6b" :weight bold)
          (?B :foreground "#5C5CFF" :weight bold)
          (?C :foreground "#c678dd" :weight bold))
        org-agenda-block-separator 8411))

(after! org-capture
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/org/todo.org" "Tasks")
           "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"))))

(setq org-agenda-custom-commands
      '(("v" "Custom agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (agenda "" ((org-agenda-ndays 1)))
          (alltodo ""
                   ((org-agenda-skip-function '(org-agenda-skip-if nil '(scheduled deadline)))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         ((org-agenda-compact-blocks nil)))))

(use-package! org-superstar
  :defer t
  :hook (org-mode . org-superstar-mode))

(use-package! org-fancy-priorities
  :defer t
  :hook (org-mode . org-fancy-priorities-mode))
