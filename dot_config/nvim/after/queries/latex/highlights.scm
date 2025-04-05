;extends
("\\item" @punctuation.special (#set! conceal "•"))
("\\ii" @punctuation.special (#set! conceal "•"))
("\\section" @module (#set! conceal "§"))
((section
   text: (curly_group
          "\{"@punctuation.brackets))
 (#set! conceal " "))
((section
   text: (curly_group
          "\}"@punctuation.brackets))
 (#set! conceal ""))
("\\subsection" @module (#set! conceal "‡"))
((subsection
   text: (curly_group
          "\{"@punctuation.brackets))
 (#set! conceal " "))
((subsection
   text: (curly_group
          "\}"@punctuation.brackets))
 (#set! conceal ""))
("\$" @markup.math.latex (#set! conceal ""))
("\\[" @markup.math.latex (#set! conceal ""))
("\\]" @markup.math.latex (#set! conceal ""))
; math conceals
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\RR")
    ) (#set! conceal "ℝ") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\times")
    ) (#set! conceal "×") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\footnote")
    ) (#set! conceal "†") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\dots")
    ) (#set! conceal "…") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\CC")
    ) (#set! conceal "ℂ") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\QQ")
    ) (#set! conceal "ℚ") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\ZZ")
    ) (#set! conceal "ℤ") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\in")
    ) (#set! conceal "∈") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\le")
    ) (#set! conceal "≤") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\ge")
    ) (#set! conceal "≥") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\\\")
    ) (#set! conceal "⏎") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\%")
    ) (#set! conceal "\%") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\#")
    ) (#set! conceal "\#") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\$")
    ) (#set! conceal "\$") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\Sigma")
    ) (#set! conceal "Σ") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\textbf")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    arg: (curly_group
           "\{"@punctuation.brackets)
    (#eq? @markup.math "\\textbf")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    arg: (curly_group
           "\}"@punctuation.brackets)
    (#eq? @markup.math "\\textbf")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\mathbf")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\emph")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    arg: (curly_group
           "\{"@punctuation.brackets)
    (#eq? @markup.math "\\emph")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    arg: (curly_group
           "\}"@punctuation.brackets)
    (#eq? @markup.math "\\emph")
   )(#set! conceal "") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\mid")
    ) (#set! conceal "|") )
( (generic_command
    command: (command_name) @markup.math
    (#eq? @markup.math "\\tableofcontents")
    ) (#set! conceal "󰠶") )
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_1"))
   (#set! conceal "₁"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_2"))
   (#set! conceal "₂"))

( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_3"))
   (#set! conceal "₃"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_4"))
   (#set! conceal "₄"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_5"))
   (#set! conceal "₅"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_6"))
   (#set! conceal "₆"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_7"))
   (#set! conceal "₇"))

( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_8"))
   (#set! conceal "₈"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_9"))
   (#set! conceal "₉"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_0"))
   (#set! conceal "₀"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_a"))
   (#set! conceal "ₐ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_i"))
   (#set! conceal "ᵢ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_e"))
   (#set! conceal "ₑ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_o"))
   (#set! conceal "ₒ"))

( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_c"))
   (#set! conceal "꜀"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_h"))
   (#set! conceal "ₕ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_j"))
   (#set! conceal "ⱼ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_k"))
   (#set! conceal "ₖ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_l"))
   (#set! conceal "ₗ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_m"))
   (#set! conceal "ₘ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_n"))
   (#set! conceal "ₙ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_o"))
   (#set! conceal "ₒ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_p"))
   (#set! conceal "ₚ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_s"))
   (#set! conceal "ₛ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_t"))
   (#set! conceal "ₜ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_u"))
   (#set! conceal "ᵤ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_v"))
   (#set! conceal "ᵥ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_v"))
   (#set! conceal "ₓ"))
( (text
    word: (subscript
            subscript: (letter)) @markup.math
    (#eq? @markup.math "_v"))
   (#set! conceal "ᵧ"))
; whew
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^1"))
   (#set! conceal "¹"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^2"))
   (#set! conceal "²"))

( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^3"))
   (#set! conceal "³"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^4"))
   (#set! conceal "⁴"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^5"))
   (#set! conceal "⁵"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^6"))
   (#set! conceal "⁶"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^7"))
   (#set! conceal "⁷"))

( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^8"))
   (#set! conceal "⁸"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^9"))
   (#set! conceal "⁹"))
( (text
    word: (superscript
            superscript: (letter)) @markup.math
    (#eq? @markup.math "^0"))
   (#set! conceal "⁰"))
; TODO: fractions fractions fractions
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{1}{2}") (#set! conceal "½") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{1}{5}") (#set! conceal "⅓") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{1}{5}") (#set! conceal "⅕") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{1}{6}") (#set! conceal "⅙") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{1}{8}") (#set! conceal "⅛") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{2}{3}") (#set! conceal "⅔") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{2}{5}") (#set! conceal "⅖") )
( (generic_command
    ) @markup.math (#eq? @markup.math "\\frac{5}{6}") (#set! conceal "⅚") )
