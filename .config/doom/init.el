;; -*- lexical-binding: t -*-
(defadvice! straight-use-recipes-ignore-nongnu-elpa-a (fn recipe)
  :around #'straight-use-recipes
  (unless (eq 'nongnu-elpa (car recipe))
    (funcall fn recipe)))

(setenv "LSP_USE_PLISTS" "1")

(doom! :input
       :completion
       ( corfu)
       (vertico +icons)           ; the search engine of the future
       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       (emoji +unicode)  ; 🙂
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       (ligatures)         ; ligatures and symbols to make your code pretty again
       (modeline +light)          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup +defaults +all)   ; tame sudden yet inevitable temporary windows
       tabs              ; a tab bar for Emacs
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
       (dired +icons)             ; making dired pretty [functional]
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
       (lsp)               ; M-x vscode
       magit             ; a git porcelain for Emacs
       pdf               ; pdf enhancements
       rgb               ; creating color strings
       tree-sitter       ; syntax and parsing, sitting in a tree...
       :os
       ;; (:if IS-MAC macos)  ; improve compatibility with macOS
       ( tty +osc)               ; improve the terminal Emacs experience
       :lang
       (agda +local)              ; types of types of types of types...
       emacs-lisp        ; drown in parentheses
       (haskell +lsp +tree-sitter)    ; a language that's lazier than I am
       idris             ; a language you can depend on
       json              ; At least it ain't XML
       (javascript +lsp +tree-sitter)        ; all(hope(abandon(ye(who(enter(here))))))
       (latex +lsp +latexmk)             ; writing papers in Emacs has never been so fun
       (java +lsp)
       (ocaml +lsp)             ; an objective camel
       (rust +lsp)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (scala +lsp)             ; java, but good
       ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;(cc +lsp)         ; C > C++ == 1
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;; markdown          ; writing docs for people to ignore
       ( sh +lsp +tree-sitter)                ; she sells {ba,z,fi}sh shells on the C xor
       ;; (org +pretty)               ; organize your plain life in plain text
       (ruby +lsp +tree-sitter)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ( web +lsp)               ; the tubes
       (lua +lsp +tree-sitter)
       :email
       ;; (mu4e +gmail)
       :app
       ;; (rss)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought
       :config
       (default +bindings +smartparens))
