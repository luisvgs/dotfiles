(add-to-list 'treesit-extra-load-path
             (expand-file-name "~/.config/doom/local/grammars"))

(defvar maude-ts-font-lock-rules
  '(:language maude
    :feature keyword
    ((keyword) @font-lock-keyword-face)

    :language maude
    :feature type
    ((base_type) @font-lock-type-face)
    ))

(defun maude-ts-setup ()
  (setq-local treesit-font-lock-settings
              (apply #'treesit-font-lock-rules maude-ts-font-lock-rules))
  (setq-local treesit-font-lock-feature-list '((keyword type)))
  (treesit-major-mode-setup))

(define-derived-mode maude-ts-mode prog-mode "Maude"
  (when (treesit-ready-p 'maude)
    (maude-ts-setup)))

(add-to-list 'auto-mode-alist '("\\.maude\\'" . maude-ts-mode))
;; (defconst maude--font-lock-keywords
;;   (let (
;;         (keywords '("op"
;;                     "fmod"
;;                     "is"
;;                     "endfm"
;;                     "sort"
;;                     "protecting"
;;                     "vars"
;;                     "sorts"
;;                     "subsort"
;;                     "including"
;;                     "var"
;;                     "eq"))
;;         (types '("Nat" "BOOL" "NAT" "Bool" "STRING")))
;;     `((,(rx-to-string
;;          `(: word-start (or ,@keywords) word-end)) 0 font-lock-keyword-face)
;;       (,(rx-to-string
;;          `(: word-start (or ,@types) word-end)) 0 font-lock-type-face))))


;; (defun maude-load-file ()
;;   (interactive)
;;   (let ((file (buffer-file-name)))
;;     (maude-open-repl)
;;     (comint-send-string "*maude*"
;;                         (format "in %s .\n" file))))

;; (defun maude-open-repl()
;;   (interactive)
;;   (unless (get-buffer "*maude*")
;;     (make-comint "maude" "maude" nil "-interactive"))
;;   (switch-to-buffer-other-window "*maude*"))

;; (define-derived-mode maude-mode
;;   prog-mode
;;   "maude"
;;   "My personal major mode for maude"
;;   (setq font-lock-defaults '(maude--font-lock-keywords)))

;; (define-key maude-mode-map (kbd "C-c C-r") #'maude-open-repl)
;; (define-key maude-mode-map (kbd "C-c C-l") #'maude-load-file)
