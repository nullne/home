" vim: ft=vim:fdm=marker

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Keywords {{{
" ============

    syn keyword pythonStatement	break continue del
    syn keyword pythonStatement	exec return
    syn keyword pythonStatement	pass raise
    syn keyword pythonStatement	global assert
    syn keyword pythonStatement	lambda yield
    syn keyword pythonStatement	with
    syn keyword pythonStatement	def class nextgroup=pythonFunction skipwhite
    syn match   pythonFunction	"[a-zA-Z_][a-zA-Z0-9_]*" display contained
    syn keyword pythonRepeat	for while
    syn keyword pythonConditional	if elif else
    syn keyword pythonPreCondit	import from as
    syn keyword pythonException	try except finally
    syn keyword pythonOperator	and in is not or
    syn keyword pythonStatement print

" }}}


" Decorators {{{
" ==============

    syn match   pythonDecorator	"@" display nextgroup=pythonDottedName skipwhite
    syn match   pythonDottedName "[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*" display contained
    syn match   pythonDot        "\." display containedin=pythonDottedName
    
" }}}


" Comments {{{
" ============

    syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
    syn match   pythonRun		"\%^#!.*$"
    syn match   pythonCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
    syn keyword pythonTodo		TODO FIXME XXX contained

" }}}


" Errors {{{
" ==========

    syn match pythonError		"\<\d\+\D\+\>" display
    syn match pythonError		"[$?]" display
    syn match pythonError		"[&|]\{2,}" display
    syn match pythonError		"[=]\{3,}" display

    " Indent errors (mix space and tabs)
    syn match pythonIndentError	"^\s*\( \t\|\t \)\s*\S"me=e-1 display

    " Trailing space errors
    syn match pythonSpaceError	"\s\+$" display

" }}}


" Strings {{{
" ===========

    syn region pythonString		start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
    syn region pythonString		start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
    syn region pythonString		start=+[bB]\="""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2,pythonSpaceError,@Spell
    syn region pythonString		start=+[bB]\='''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,@Spell

    syn match  pythonEscape		+\\[abfnrtv'"\\]+ display contained
    syn match  pythonEscape		"\\\o\o\=\o\=" display contained
    syn match  pythonEscapeError	"\\\o\{,2}[89]" display contained
    syn match  pythonEscape		"\\x\x\{2}" display contained
    syn match  pythonEscapeError	"\\x\x\=\X" display contained
    syn match  pythonEscape		"\\$"

    " Unicode
    syn region pythonUniString	start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
    syn region pythonUniString	start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
    syn region pythonUniString	start=+[uU]"""+ end=+"""+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
    syn region pythonUniString	start=+[uU]'''+ end=+'''+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell

    syn match  pythonUniEscape	        "\\u\x\{4}" display contained
    syn match  pythonUniEscapeError     "\\u\x\{,3}\X" display contained
    syn match  pythonUniEscape	        "\\U\x\{8}" display contained
    syn match  pythonUniEscapeError     "\\U\x\{,7}\X" display contained
    syn match  pythonUniEscape	        "\\N{[A-Z ]\+}" display contained
    syn match  pythonUniEscapeError	"\\N{[^A-Z ]\+}" display contained

    " Raw strings
    syn region pythonRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
    syn region pythonRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
    syn region pythonRawString	start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
    syn region pythonRawString	start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

    syn match pythonRawEscape	        +\\['"]+ display transparent contained

    " Unicode raw strings
    syn region pythonUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
    syn region pythonUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
    syn region pythonUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2,pythonSpaceError,@Spell
    syn region pythonUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest,pythonSpaceError,@Spell

    syn match  pythonUniRawEscape	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
    syn match  pythonUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

    " String formatting
    syn match pythonStrFormatting	"%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    syn match pythonStrFormatting	"%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

    " Str.format syntax
    syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    syn match pythonStrFormat "{\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)\(\.[a-zA-Z_][a-zA-Z0-9_]*\|\[\(\d\+\|[^!:\}]\+\)\]\)*\(![rs]\)\=\(:\({\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)}\|\([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*\(\.\d\+\)\=[bcdeEfFgGnoxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

    " String templates
    syn match pythonStrTemplate "\$\$" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    syn match pythonStrTemplate "\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
    syn match pythonStrTemplate "\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

    " DocTests
    syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
    syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained

" }}}

" Numbers {{{
" ===========

    syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display
    syn match   pythonHexNumber	"\<0[xX]\x\+[lL]\=\>" display
    syn match   pythonOctNumber "\<0[oO]\o\+[lL]\=\>" display
    syn match   pythonBinNumber "\<0[bB][01]\+[lL]\=\>" display
    syn match   pythonNumber	"\<\d\+[lLjJ]\=\>" display
    syn match   pythonFloat	"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
    syn match   pythonFloat	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
    syn match   pythonFloat	"\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display
    syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
    syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*[lL]\=\>" display

" }}}

" Builtins {{{
" ============

    " Builtin objects and types
    syn keyword pythonBuiltinObj True False Ellipsis None NotImplemented
    syn keyword pythonBuiltinObj __debug__ __doc__ __file__ __name__ __package__
    syn keyword pythonBuiltinObj self

    " Builtin functions
    syn keyword pythonBuiltinFunc	__import__ abs all any apply
    syn keyword pythonBuiltinFunc	basestring bin bool buffer bytearray bytes callable
    syn keyword pythonBuiltinFunc	chr classmethod cmp coerce compile complex
    syn keyword pythonBuiltinFunc	delattr dict dir divmod enumerate eval
    syn keyword pythonBuiltinFunc	execfile file filter float format frozenset getattr
    syn keyword pythonBuiltinFunc	globals hasattr hash help hex id
    syn keyword pythonBuiltinFunc	input int intern isinstance
    syn keyword pythonBuiltinFunc	issubclass iter len list locals long map max
    syn keyword pythonBuiltinFunc	min next object oct open ord
    syn keyword pythonBuiltinFunc	pow property range
    syn keyword pythonBuiltinFunc	raw_input reduce reload repr
    syn keyword pythonBuiltinFunc	reversed round set setattr
    syn keyword pythonBuiltinFunc	slice sorted staticmethod str sum super tuple
    syn keyword pythonBuiltinFunc	type unichr unicode vars xrange zip

    syn keyword pythonBuiltinFunc	print


    " Builtin exceptions and warnings
    syn keyword pythonExClass	BaseException
    syn keyword pythonExClass	Exception StandardError ArithmeticError
    syn keyword pythonExClass	LookupError EnvironmentError
    syn keyword pythonExClass	AssertionError AttributeError BufferError EOFError
    syn keyword pythonExClass	FloatingPointError GeneratorExit IOError
    syn keyword pythonExClass	ImportError IndexError KeyError
    syn keyword pythonExClass	KeyboardInterrupt MemoryError NameError
    syn keyword pythonExClass	NotImplementedError OSError OverflowError
    syn keyword pythonExClass	ReferenceError RuntimeError StopIteration
    syn keyword pythonExClass	SyntaxError IndentationError TabError
    syn keyword pythonExClass	SystemError SystemExit TypeError
    syn keyword pythonExClass	UnboundLocalError UnicodeError
    syn keyword pythonExClass	UnicodeEncodeError UnicodeDecodeError
    syn keyword pythonExClass	UnicodeTranslateError ValueError VMSError
    syn keyword pythonExClass	WindowsError ZeroDivisionError
    syn keyword pythonExClass	Warning UserWarning BytesWarning DeprecationWarning
    syn keyword pythonExClass	PendingDepricationWarning SyntaxWarning
    syn keyword pythonExClass	RuntimeWarning FutureWarning
    syn keyword pythonExClass	ImportWarning UnicodeWarning

" }}}

syn match pythonOper    "=\|+\|-\|*\|{\|}\|[\|]\|(\|)\|\.\|,\|:"

syn sync minlines=2000
" This is fast but code inside triple quoted strings screws it up. It
" is impossible to fix because the only way to know if you are inside a
" triple quoted string is to start from the beginning of the file.
syn sync match pythonSync grouphere NONE "):$"
syn sync maxlines=200

" Highlight {{{
" =============

    hi def link  pythonStatement    Statement
    hi def link  pythonPreCondit    Statement
    hi def link  pythonFunction	    Function
    hi def link  pythonConditional  Conditional
    hi def link  pythonRepeat       Repeat
    hi def link  pythonException    Exception
    hi def link  pythonOperator	    Operator

    hi def link  pythonDecorator    Define
    hi def link  pythonDottedName   Function
    hi def link  pythonDot          Normal

    hi def link  pythonComment	    Comment
    hi def link  pythonCoding	    Special
    hi def link  pythonRun	    Special
    hi def link  pythonTodo	    Todo

    hi def link  pythonError	    Error
    hi def link  pythonIndentError  Error
    hi def link  pythonSpaceError   Error

    hi def link  pythonString	    String
    hi def link  pythonUniString    String
    hi def link  pythonRawString    String
    hi def link  pythonUniRawString String

    hi def link  pythonEscape	    Special
    hi def link  pythonEscapeError  Error
    hi def link  pythonUniEscape    Special
    hi def link  pythonUniEscapeError Error
    hi def link  pythonUniRawEscape Special
    hi def link  pythonUniRawEscapeError Error

    hi def link  pythonStrFormatting Special
    hi def link  pythonStrFormat    Special
    hi def link  pythonStrTemplate  Special

    hi def link  pythonDocTest	    Special
    hi def link  pythonDocTest2	    Special

    hi def link  pythonNumber	    Number
    hi def link  pythonHexNumber    Number
    hi def link  pythonOctNumber    Number
    hi def link  pythonBinNumber    Number
    hi def link  pythonFloat	    Float
    hi def link  pythonOctError	    Error
    hi def link  pythonHexError	    Error
    hi def link  pythonBinError	    Error

    hi def link  pythonBuiltinObj   Structure
    hi def link  pythonBuiltinFunc  Function

    hi def link  pythonExClass	    Structure

" }}}

hi def link pythonOper            SpecialKey