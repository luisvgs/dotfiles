(use-package! org
  :defer t
  :mode ("\\.org\\'" . org-mode))

(use-package! rainbow-mode :after org-mode)
(after! org org-directory "~/org/")

(setq org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
      org-deadline-warning-days 0
      org-agenda-span 7
      org-agenda-start-day "-0d"
      org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
      org-log-done 'time)

(after! org-fancy-priorities
  (setq org-fancy-priorities-list '("❗" "[B]" "[C]")
        org-priority-faces
        '((?A :foreground "#ff6c6b" :weight bold)
          (?B :foreground "#5C5CFF" :weight bold)
          (?C :foreground "#c678dd" :weight bold))
        org-agenda-block-separator 8411))

(after! org-capture
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/org/todo.org" "Tasks")
           "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
          ("j" "Journal Entry"
           entry (file+datetree "~/org/journal.org")
           "* %?"
           :empty-lines 1)
          )
        ))

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

(after! org-modern
  (setq org-modern-fold-stars '(("◉" . "◉") ("○" . "○") ("◈" . "◈") ("◇" . "◇") ("◦" . "◦")))
  )

(use-package! org-fancy-priorities
  :defer t
  :hook (org-mode . org-fancy-priorities-mode))

;; TODO conditionally change the bg depending on current theme.
(custom-set-faces!
  '(org-level-4 :inherit outline-4 :height 1.0)
  '(org-level-3 :inherit outline-3 :height 1.0)
  '(org-level-2 :inherit outline-2 :height 1.1)
  '(org-document-title :height 1.1 :underline nil :foreground "#8B8B8B"))

(custom-theme-set-faces!
  'doom-flatwhite
  '(org-level-4 :inherit outline-4 :height 1.0)
  '(org-level-3 :inherit outline-3 :height 1.0)
  '(org-level-2 :inherit outline-2 :height 1.1)
  '(org-level-1 :inherit outline-1 :height 1.45 :background "#feeed2")
  '(org-document-title :height 1.1 :underline nil :foreground "#8B8B8B"))

(use-package! citar
  :after org
  :config
  (setq citar-bibliography '("~/org/references.bib")
        citar-library-paths '("~/Zotero/storage/")
        citar-notes-paths '("~/org/roam/references/"))
  (map! :map org-mode-map ("C-c b" #'org-cite-insert)))

(after! oc
  (setq org-cite-global-bibliography '("~/org/references.bib")))

(after! org
  (add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))
  (org-link-set-parameters "zotero"
                           :follow (lambda (zpath)
                                     (browse-url (format "zotero:%s" zpath)))))

;; (use-package! citar-org-roam
;;   :disable t
;;   :after (citar org-roam)
;;   :config
;;   (setq org-roam-directory "~/org/roam")
;;   (citar-org-roam-mode))


(defun my/org-roam-node-from-cite (citekey)
  (interactive (list (citar-org-select-key nil)))
  (let* ((entry (citar-get-entry citekey))
         (author (or (citar-get-value "author" entry)
                     (citar-get-value "editor" entry)
                     "Unknown"))
         (title (or (citar-get-value "title" entry) citekey))
         (display-title (concat author " :: " title)))
    (org-roam-capture-
     :templates
     '(("r" "reference" plain "%?"
        :if-new
        (file+head "references/${citekey}.org"
                   ":PROPERTIES:\n:ROAM_REFS: @${citekey}\n:END:\n#+title: ${title}\n#+filetags: :reading:\n")
        :immediate-finish t
        :unnarrowed t))
     :info (list :citekey citekey :title display-title)
     :node (org-roam-node-create :title display-title)
     :props '(:finalize find-file))))
(map! :leader :desc "New ref note" "n r R" #'my/org-roam-node-from-cite)


;; (use-package! org-roam
;;   :disable t
;;   :defer t
;;   :after org
;;   :custom
;;   (org-roam-directory (file-truename "~/org/roam"))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n g" . org-roam-graph)
;;          ("C-c n i" . org-roam-node-insert)
;;          ("C-c n c" . org-roam-capture)
;;          ;; Dailies
;;          ("C-c n j" . org-roam-dailies-capture-today))
;;   :config
;;   ;; If you're using a vertical completion framework, you might want a more informative completion interface
;;   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   (org-roam-db-autosync-mode)
;;   ;; If using org-roam-protocol
;;   (require 'org-roam-protocol))

;; (use-package! org-roam-ui
;;   :disable t
;;   :after org-roam
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t))
