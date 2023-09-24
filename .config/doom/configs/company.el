(use-package! company
  :after lsp-mode
  :diminish
  :hook (lsp-mode . company-mode)
  )
