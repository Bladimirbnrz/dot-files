;; extends

; Highlight text-format commands 
((generic_command
   command: (command_name) @markup.textformat)
 (#any-of? @markup.textformat
   "\\large" "\\Large" "\\LARGE"
   "\\small" "\\footnotesize" "\\scriptsize" "\\tiny"
   "\\huge" "\\Huge"
   "\\bfseries" "\\itshape" "\\scshape" "\\ttfamily"
   "\\normalsize" "\\rmfamily" "\\sffamily"
   "\\upshape" "\\mdseries")
 (#set! priority 110))

; Not highlight some short commands
((generic_command
   command: (command_name) @markup.is_not_cmd)
 (#any-of? @markup.is_not_cmd
  "\\" "\\\\")
 (#set! priority 110))


; Highlight some special command args
((generic_command
   command: (command_name) @_cmd
   . (curly_group) @markup.arg.cmd)
 (#any-of? @_cmd "\\vspace" "\\vspace*" "\\hspace" "\\hspace*")
 (#set! priority 50))


; Highlight math delimiters
((generic_command
   command: (command_name) @delim.mine.math)
   (#any-of? @delim.mine.math 
   "\\{" "\\}"
   "\\langle" "\\rangle"
   "\\lfloor" "\\rfloor"
   "\\lceil" "\\rceil"
   "\\vert" "\\Vert"
   "\\big" "\\Big" "\\bigg" "\\Bigg"
   "\\bigl" "\\bigr" "\\Bigl" "\\Bigr" "\\biggl" "\\biggr" "\\Biggl" "\\Biggr")
   (#set! priority 200))

(math_delimiter
  left_delimiter: _ @delim.mine.math)

(math_delimiter
  right_delimiter: _ @delim.mine.math)

(math_environment
  ["(" ")" "[" "]"] @delim.mine.math)

([
   (superscript (curly_group ["{" "}"] @operator.latex))
   (subscript (curly_group ["{" "}"] @operator.latex))
 ]
 (#set! priority 100))


; Highlight as Normal Text, Text in math
(math_environment) @nospell

((text_mode
   content: (curly_group
     (text) @normal.text @spell))
 (#set! priority 120))


; Highlight enumarate/itemize items
(enum_item
  label: (brack_group_text) @enum.item)


; Add rules for Chapter,Sub/Sub/Section highlight
[
  ((chapter
    command: _ @markup.heading.cmd
    text: (curly_group) @markup.heading)
   (#set! priority 110))
  ((section
    command: _ @markup.heading.cmd
    text: (curly_group) @markup.heading)
   (#set! priority 110))
  ((subsection
    command: _ @markup.heading.cmd
    text: (curly_group) @markup.heading)
   (#set! priority 110))
  ((subsubsection
    command: _ @markup.heading.cmd
    text: (curly_group) @markup.heading)
   (#set! priority 110))
  ((title_declaration
    command: _ @markup.heading.cmd
    text: (curly_group) @markup.heading)
   (#set! priority 110))
]

((generic_command
   command: (command_name) @markup.heading.cmd
   . (curly_group) @markup.heading)
 (#any-of? @markup.heading.cmd "\\usection" "\\usubsection" "\\usubsubsection")
 (#set! priority 110)) ; you can add more heading custom commands


; TEST

; ((math_environment
;   begin: (begin) @name.mine.env.math
;   end: (end) @name.mine.env.math)
;  (#set! priority 200))

; ([
;    (begin name: (curly_group_text (text) @name.mine.env.math))
;    (end name: (curly_group_text (text) @name.mine.env.math))
;  ]
;  (#any-of? @name.mine.env.math
;    "equation" "equation*"
;    "align" "align*"
;    "alignat" "alignat*"
;    "gather" "gather*"
;    "multline" "multline*"
;    "flalign" "flalign*"
;    "eqnarray" "eqnarray*"
;    "empheq"
;    "cases" "dcases"
;    "math" "displaymath"))
