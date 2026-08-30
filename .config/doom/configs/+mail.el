(after! notmuch
  (setq notmuch-saved-searches
        '((:name "inbox"
           :query "tag:inbox"
           :key "i")
          (:name "unread"
           :query "tag:unread"
           :key "u")
          (:name "flagged"
           :query "tag:flagged"
           :key "f")
          (:name "sent"
           :query "tag:sent"
           :key "s")
          (:name "drafts"
           :query "folder:drafts"
           :key "d")
          (:name "trash"
           :query "tag:trash"
           :key "t")
          (:name "all mail"
           :query "*"
           :key "a")))
  (setq notmuch-show-logo nil
        notmuch-hello-sections
        '(notmuch-hello-insert-header
          notmuch-hello-insert-saved-searches
          notmuch-hello-insert-alltags
          notmuch-hello-insert-footer))
  (add-hook 'notmuch-hello-mode-hook #'delete-other-windows))

(use-package! notmuch-indicator
  :config
  (setq notmuch-indicator-args
        '((:terms "tag:unread and tag:inbox"
           :label "📩"))
        notmuch-indicator-refresh-count 180
        notmuch-indicator-hide-empty-counters t)
  (notmuch-indicator-mode 1))
(defun my/notmuch-inbox ()
  "Open notmuch inbox"
  (interactive)
  (require 'notmuch)
  (notmuch-search "tag:inbox"))

(map!
 :leader
 :desc "Open notmuch inbox"
 "o i" #'my/notmuch-inbox)
