;; -*- lexical-binding: t -*-
;; (defadvice! straight-use-recipes-ignore-nongnu-elpa-a (fn recipe)
;;   :around #'straight-use-recipes
;;   (unless (eq 'nongnu-elpa (car recipe))
;;     (funcall fn recipe)))

(setenv "LSP_USE_PLISTS" "1")

(doom! :input
       :completion
       (corfu)
       (ivy +icons +fuzzy +prescient)           ; the search engine of the future
       :ui
       doom              ; what makes DOOM look the way it does
       ;; doom-dashboard    ; a nifty splash screen for Emacs
       nav-flash
       (treemacs)
       (emoji +unicode)  ; 🙂
       hl-todo
       (ligatures)
       (modeline)
       ophints           ; highlight the region an operation acts on
       (popup +defaults +all)   ; tame sudden yet inevitable temporary windows
       ;; tabs              ; a tab bar for Emacs
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       ;;window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       ;;zen               ; distraction-free coding or writing
       :editor
       (evil +everywhere); come to the dark side, we have cookies
       ;;file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to

       :emacs
       (dired +icons +dirvish)             ; making dired pretty [functional]
       ;; electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)         ; interactive buffer management
       (undo +tree)              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree
       :term
       vterm             ; the best terminal emulation in Emacs
       :checkers
       (syntax)              ; tasing you for every semicolon you forget
       :tools
       lookup              ; navigate your code and its documentation
       (lsp +eglot +booster)               ; M-x vscode
       ( magit +forge)             ; a git porcelain for Emacs
       pdf               ; pdf enhancements
       rgb               ; creating color strings
       tree-sitter       ; syntax and parsing, sitting in a tree...
       :os
       ;; (:if IS-MAC macos)  ; improve compatibility with macOS
       ( tty +osc)               ; improve the terminal Emacs experience
       :lang
       (agda +local)              ; types of types of types of types...
       emacs-lisp        ; drown in parentheses
       (haskell +eglot +tree-sitter)    ; a language that's lazier than I am
       idris             ; a language you can depend on
       json              ; At least it ain't XML
       (javascript +eglot +tree-sitter)        ; all(hope(abandon(ye(who(enter(here))))))
       (latex +eglot +latexmk)             ; writing papers in Emacs has never been so fun
       ;; (java +lsp)
       ;; (clojure +lsp +tree-sitter)
       ;; (ocaml +lsp)             ; an objective camel
       (rust)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (fsharp)
       (python +tree-sitter)
       ;; (scala +lsp)             ; java, but good
       ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;(cc +lsp)         ; C > C++ == 1
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ( markdown +tree-sitter +grip)          ; writing docs for people to ignore
       ;; ( sh +lsp +tree-sitter)                ; she sells {ba,z,fi}sh shells on the C xor
       ;; (org +pretty)               ; organize your plain life in plain text
       (ruby +tree-sitter)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (web +eglot)               ; the tubes
       (lua +eglot +tree-sitter)
       :email
       (mu4e +gmail +mbsync)
       ;; (notmuch)
       :app
       ;; (rss)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought
       :config
       (default +bindings +smartparens))
