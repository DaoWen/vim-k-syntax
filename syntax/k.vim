" Vim syntax file

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50

" most K keywords
syn keyword kKeyword syntax rule configuration when
syn match kKeyword "|->"
syn match kKeyword "=>"
syn match kKeyword "<-"
syn match kKeyword "\<_\>"
syn match kKeyword "\~>"

syn match kKeyword "::=" "this is not a type

" package and import statements
syn keyword kPackage package nextgroup=kFqn skipwhite
syn keyword kImport require imports nextgroup=kFqn skipwhite
syn match kFqn "\<[._$a-zA-Z0-9,]*" contained nextgroup=kFqnSet
syn region kFqnSet start="{" end="}" contained

" boolean literals
syn match kVars "$\w\+"
syn keyword kBoolean true false

" definitions
syn keyword kModule module nextgroup=kClassName skipwhite
syn keyword kEndModule endmodule
syn keyword kSyntax syntax nextgroup=kDefName skipwhite
syn match kDefName "[^ =:;([]\+" contained skipwhite
syn match kValName "[^ =:;([]\+" contained
syn match kVarName "[^ =:;([]\+" contained 
syn match kClassName "[^ =:;(\[]\+" contained nextgroup=kClassSpecializer skipwhite
syn region kDefSpecializer start="\[" end="\]" contained contains=kDefSpecializer
syn region kClassSpecializer start="\[" end="\]" contained contains=kClassSpecializer

" type constructor (actually anything with an uppercase letter)
syn match kConstructor "\<[A-Z][_$a-zA-Z0-9]*\>" nextgroup=kConstructorSpecializer
syn region kConstructorSpecializer start="\[" end="\]" contained contains=kConstructorSpecializer

" method call
syn match kRoot "\<[a-zA-Z][_$a-zA-Z0-9]*\."me=e-1
syn match kMethodCall "\.[a-z][_$a-zA-Z0-9]*"ms=s+1

" type declarations in val/var/def
syn match kType ":\s*\(\s*\)\?#\?[._$a-zA-Z0-9]\+\(\[[^]]*\]\+\)\?\(\s*\(<:\|>:\|#\)\s*[._$a-zA-Z0-9]\+\(\[[^]]*\]\+\)*\)*"ms=s+1

" comments
syn match kTodo "[tT][oO][dD][oO]" contained
syn match kLineComment "//.*" contains=kTodo
syn region kComment start="/\*" end="\*/" contains=kTodo
syn region kDocComment start="/\*\*" end="\*/" contains=kDocTags,kTodo,@kHtml keepend
syn region kDocTags start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}" contained
syn match kDocTags "@[a-z]\+" contained

syn match kEmptyString "\"\""

" multi-line string literals
syn region kMultiLineString start="\"\"\"" end="\"\"\"" contains=kUnicode
syn match kUnicode "\\u[0-9a-fA-F]\{4}" contained

" string literals with escapes
syn region kString start="\"[^"]" skip="\\\"" end="\"" contains=kStringEscape " TODO end \n or not?
syn match kStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match kStringEscape "\\[nrfvb\\\"]" contained

" symbol and character literals
syn match kSymbol "'[_a-zA-Z0-9][_a-zA-Z0-9]*\>"
syn match kChar "'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'"

" number literals
syn match kNumber "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match kNumber "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match kNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match kNumber "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" xml literals
syn match kXmlTag "</\?[a-zA-Z]\_[^>]*/\?>" contains=kXmlQuote,kXmlString
syn region kXmlString start="\"" end="\"" contained
syn match kXmlQuote "&[^;]\+;" contained

" annotation things
syn match kSyntaxTag "\[[a-zA-Z]\_[^\]]*\]" contains=kSyntaxTagStuff
syn match kSyntaxTagStuff "[^\[\]]\+" contained

syn sync fromstart

" map K groups to standard groups
hi link kKeyword Keyword
hi link kPackage Include
hi link kImport Include
hi link kBoolean Boolean
hi link kOperator Normal
hi link kNumber Number
hi link kEmptyString String
hi link kString String
hi link kChar String
hi link kStringEscape Special
hi link kSymbol Special
hi link kUnicode Special
hi link kComment Comment
hi link kLineComment Comment
hi link kDocComment SpecialComment
hi link kTodo Todo
hi link kType Type
hi link kTypeSpecializer kType
hi link kXmlTag Include
hi link kXmlString String
hi link kXmlQuote Special
hi link kModule Keyword
hi link kEndModule Keyword
hi link kSyntax Keyword
hi link kDefName Function
hi link kClassName Special
hi link kSyntaxTag Special

let b:current_syntax = "k"

" you might like to put these lines in your .vimrc
"
" customize colors a little bit (should be a different file)
" hi kNew gui=underline
" hi kMethodCall gui=italic
" hi kValName gui=underline
" hi kVarName gui=underline
