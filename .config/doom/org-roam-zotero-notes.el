;;; org-roam-zotero-notes.el -*- lexical-binding: t; -*-

(after! citar
  (add-to-list 'citar-file-open-functions '("pdf" . citar-file-open-external)))

(defun my/grab-reference-items (citekey item-list)
  (with-temp-buffer
    (mapc (lambda (f) (insert-file-contents f)) citar-bibliography)
    (let* ((start (search-forward (concat "{" citekey ",") nil nil))
           (start (if start (line-beginning-position) nil))
           (end (if start
                    (save-excursion
                      (goto-char start)
                      (or (search-forward "\n@" nil t) (point-max)))
                  nil)))
      (mapcar (lambda (item)
                (let* ((item-start (when start
                                     (goto-char start)
                                     (search-forward (format "%s = {" item) end t)))
                       (item-end (when item-start (progn (up-list) (point)))))
                  (if item-start
                      (buffer-substring-no-properties item-start item-end)
                    "")))
              item-list))))

(defun my/parse-zotero-note-entry (entry)
  (let* ((page-match (string-match "(\\([^,]+\\),\s*p\\.\s*\\([0-9]+\\))" entry))
         (page (when page-match (match-string 2 entry)))
         (quote-match (string-match "\u201c\\([^\u201d]+\\)\u201d" entry))
         (quote (when quote-match (match-string 1 entry))))
    (when quote
      (concat (if page (format "*** p. %s\n" page) "*** nota\n")
              (format "#+BEGIN_QUOTE\n%s\n#+END_QUOTE\n" quote)))))

(defun my/parse-zotero-notes (notes url)
  (let* ((url (replace-regexp-in-string "?.*" "" url))
         (entries (split-string notes "\\\\par[\s\n]+"))
         (entries (seq-filter (lambda (e) (string-match-p "\u201c" e)) entries))
         (parsed (remq nil (mapcar #'my/parse-zotero-note-entry entries))))
    (if parsed
        (mapconcat 'identity parsed "\n")
      "")))

(defun my/update-zotero-notes ()
  (interactive)
  (when (get-buffer-window)
    (save-excursion
      (goto-char (point-min))
      (let* ((start (search-forward ":ROAM_REFS: @" nil t))
             (end (when start (progn (forward-word) (point)))))
        (when (and start end)
          (let* ((citekey (buffer-substring-no-properties start end))
                 (items (my/grab-reference-items citekey '(note file)))
                 (notes (nth 0 items))
                 (file-url (nth 1 items)))
            (when (and notes (not (string-empty-p notes)))
              (let* ((parsed (my/parse-zotero-notes notes (or file-url "")))
                     (data (org-element-parse-buffer 'greater-elements))
                     (bounds (org-element-map data 'headline
                               (lambda (el)
                                 (and (string= "zotero notes"
                                               (org-element-property :raw-value el))
                                      (list (org-element-property :begin el)
                                            (org-element-property :end el))))
                               nil t)))
                (when (nth 0 bounds)
                  (delete-region (nth 0 bounds) (nth 1 bounds)))
                (when (not (string-empty-p parsed))
                  (save-excursion
                    (goto-char (point-max))
                    (insert "* zotero notes\n" parsed)))))))))))

(add-hook 'find-file-hook #'my/update-zotero-notes)
(add-hook 'after-save-hook #'my/update-zotero-notes)

(provide 'org-roam-zotero-notes)
