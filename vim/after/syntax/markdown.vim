" Vim patterns can match word boundaries (:help word, :help /\<, :help /\>)
" but cannot match WORD boundaries (:help WORD). See:
"
" • https://vi.stackexchange.com/q/37995
"   ↳ Neovim wont match beginning of word with # sign
"
" TODO(serban): Consider using \f (:help \f) to match paths. See :help isfname.

syntax match   SerbanAcronym           '\v<\u+s?>'                contains=@NoSpell containedin=mkdNonListItemBlock,mkdListItemLine,mkdBlockquote,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlBold,htmlItalic,htmlBoldItalic

syntax match   SerbanUrl               '\v<https?://\S+>'                           containedin=mkdNonListItemBlock,mkdListItemLine nextgroup=SerbanLinkSeparator
syntax match   SerbanShortLink         '\v<(b|cl|g|go|google3|g3doc|omg|yaqs)/\S+>' containedin=mkdNonListItemBlock,mkdListItemLine nextgroup=SerbanLinkSeparator
syntax match   SerbanLinkSeparator     '\v - '                                                                                      nextgroup=SerbanLinkTitle
syntax match   SerbanLinkTitle         '\v.*$'                                                                                      contained
syntax match   SerbanAbsolutePath      '\v(^|\s)\zs/\S+>'                           containedin=mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanHomePath          '\v(^|\s)\zs\~/\S+>'                         containedin=mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanDateTime          '\v<\d{4}-\d{2}-\d{2}( \d{2}:\d{2})?>'       containedin=mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanTodo              '\v<TODO(\(serban\))?:?'                     containedin=mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanUserName          '\v<\l+\@'                                   containedin=mkdNonListItemBlock,mkdListItemLine

highlight link SerbanUrl                Underlined
highlight link SerbanShortLink          Underlined
highlight link SerbanLinkSeparator      Identifier
highlight link SerbanLinkTitle          Constant
highlight link SerbanAbsolutePath       Special
highlight link SerbanHomePath           Underlined
highlight link SerbanDateTime           Identifier
highlight link SerbanTodo               Special
highlight link SerbanUserName           Statement
