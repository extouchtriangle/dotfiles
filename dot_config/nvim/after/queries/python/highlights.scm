; extends
; Sources:
; - the python/highlights.scm: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/python/highlights.scm
; - the playground: https://tree-sitter.github.io/tree-sitter/playground
; - tutorial: https://siraben.dev/2022/03/01/tree-sitter.html

; Inspiration:
; - https://gist.github.com/andrusha/952550

; Operators
;
("not" @keyword.operator (#set! conceal "¬"))
("or" @keyword.operator (#set! conceal "∨"))
("and" @keyword.operator (#set! conceal "∧"))
("in" @keyword.operator (#set! conceal "∈"))
("for" @keyword (#set! conceal "∀"))
("assert" @keyword (#set! conceal "‼"))
((identifier) @variable.builtin.python (#eq? @variable.builtin.python "self")(#set! conceal "♀"))
((true) @boolean (#set! conceal "⊤"))
((false) @boolean (#set! conceal "⊥"))
("==" @operator (#set! conceal "≝"))
; ("!=" @operator (#set! conceal "≢"))
; ("<=" @operator (#set! conceal "≤"))
; (">=" @operator (#set! conceal "≥"))
("*" @operator (#set! conceal "∙"))
("/" @operator (#set! conceal "÷"))
("=" @operator (#set! conceal "←"))

; Functions
;
; used in function call contexts, e.g. `sum(...)` -> `∑(...)`
;
((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "sum")
 (#set! conceal "∑"))

((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "all")
 (#set! conceal "∀"))

((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "any")
 (#set! conceal "∃"))

((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "len")
 (#set! conceal "#"))

((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "int")
 (#set! conceal "ℤ"))

((call function: (identifier) @function.builtin)
 (#eq? @function.builtin "float")
 (#set! conceal "ℝ"))

((call function: (attribute) @method)
 (#eq? @method "math\.sqrt")
 (#set! conceal "√"))
((call function: (attribute) @method)
 (#eq? @method "np\.sqrt")
 (#set! conceal "√"))

("lambda" @keyword.function (#set! conceal "λ"))
("as" @keyword.python (#set! conceal "⇒"))
("return" @keyword.return.python (#set! conceal "▶"))
("def" @keyword.function.python (#set! conceal "󰊕"))
("class" @keyword.function.python (#set! conceal "§"))

( (call
    function: (identifier) @function.builtin
    (#eq? @function.builtin "torch")
) (#set! conceal "p") )

; Important builtins
;
(((attribute) @constant)
 (#eq? @constant "math\.pi")
 (#set! conceal "π"))

((none) @constant.builtin (#set! conceal "Ø"))

; Main types
;
((type (identifier) @type) (#eq? @type "int") (#set! conceal "ℤ"))
((type (identifier) @type) (#eq? @type "float") (#set! conceal "ℝ"))
; get ready for the grind
; TODO: conceal powers and subscripts
