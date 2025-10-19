(use-package! latex-preview-pane
  :after latex-mode
  :hook ((latex-mode . lsp)
         (latex-mode . latex-preview-pane-mode))
  :config
  (setq latex-preview-pane-use-latexmk nil)
  (setq latex-preview-pane-multifile-mode 'auctex)
  (setq TeX-PDF-mode t)
  (add-to-list 'image-types 'gif)
  (message "Latex-preview-pane ready for PDF output."))
