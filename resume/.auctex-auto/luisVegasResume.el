;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "luisVegasResume"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "letterpaper" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("latexsym" "") ("fullpage" "empty") ("titlesec" "") ("marvosym" "") ("color" "usenames" "dvipsnames") ("verbatim" "") ("enumitem" "") ("hyperref" "hidelinks") ("fancyhdr" "") ("babel" "english") ("tabularx" "")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "glyphtounicode"
    "article"
    "art11"
    "latexsym"
    "fullpage"
    "titlesec"
    "marvosym"
    "color"
    "verbatim"
    "enumitem"
    "hyperref"
    "fancyhdr"
    "babel"
    "tabularx")
   (TeX-add-symbols
    '("resumeSubItem" 1)
    '("resumeProjectHeading" 2)
    '("resumeSubSubheading" 2)
    '("resumeSubheading" 4)
    '("resumeItem" 1)
    "resumeSubHeadingListStart"
    "resumeSubHeadingListEnd"
    "resumeItemListStart"
    "resumeItemListEnd"))
 :latex)

