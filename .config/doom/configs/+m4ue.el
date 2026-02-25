;; TODO: Load messages on startup?
(use-package! mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-root-maildir "~/Mail")
  (setq smtpmail-smtp-user     "luisvegasmor@gmail.com")
  (setq mu4e-compose-format-flowed t)
  (setq mu4e-bookmarks
        '((:name "Bandeja principal"
           :query "maildir:/INBOX AND NOT from:tumblr AND NOT from:linkedin AND NOT from:flickr"
           :key ?i)))
  (setq mu4e-drafts-folder "/INBOX")
  (setq mu4e-sent-folder   "/INBOX")
  (setq mu4e-refile-folder "/INBOX")
  (setq mu4e-trash-folder  "/INBOX")
  (setq mu4e-get-mail-command "mbsync gmail")
  (setq mu4e-index-cleanup nil)
  (setq mu4e-index-lazy-check t)
  (setq mu4e-headers-date-format "%d.%m.%y"))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-stream-type 'starttls
      smtpmail-debug-info t
      smtpmail-smtp-user "luisvegasmor@gmail.com")

(setq smtpmail-auth-credentials
      '(("smtp.gmail.com"
         587
         "luisvegasmor@gmail.com"
         "hwim ppla ntxp nook")))

(after! mu4e
  (mu4e))
;; (use-package! mu4e-alert
;;   :after mu4e
;;   :config
;;   (mu4e-alert-set-default-style 'mode-line)
;;   (mu4e-alert-enable-mode-line-display)
;;   (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display))
