" Vim patterns can match word boundaries (:help word, :help /\<, :help /\>)
" but cannot match WORD boundaries (:help WORD). See:
"
" • https://vi.stackexchange.com/q/37995
"   ↳ Neovim wont match beginning of word with # sign
"
" For base highlight groups, see :help group-name.
"
" TODO(serban): Consider using \f (:help \f) to match paths. See :help isfname.

syntax case match

syntax match   SerbanAcronym           '\v<\u+s?>'                    contains=@NoSpell containedin=Table,mkdNonListItemBlock,mkdListItemLine,mkdBlockquote,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlBold,htmlItalic,htmlBoldItalic

syntax match   SerbanUrl               '\v<https?://\S+>'                               containedin=Table,mkdNonListItemBlock,mkdListItemLine nextgroup=SerbanLinkSeparator
syntax match   SerbanShortLink         '\v<(b|cl|g|go|google3|g3doc|omg|yaqs)/\S+>'     containedin=Table,mkdNonListItemBlock,mkdListItemLine nextgroup=SerbanLinkSeparator
syntax match   SerbanLinkSeparator     '\v - '                                                                                                nextgroup=SerbanLinkTitle
syntax match   SerbanLinkTitle         '\v.*$'                                                                                                contained
syntax match   SerbanAbsolutePath      '\v(^|\s)\zs/\S+>'                               containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanHomePath          '\v(^|\s)\zs\~/\S+>'                             containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanCurrency          '\v(^|\s)\zs(\$|€)\s*(\d|,)+(\.\d\d)?>'          containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanDateTime          '\v<\d{4}-\d{2}-\d{2}( \d{2}:\d{2}(:\d{2})?)?>'  containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanTodo              '\v<TODO(\(serban\))?:?'                         containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanPend              '\v<PEND(\(serban\))?:?'                         containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanDone              '\v<DONE(\(serban\))?:?'                         containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanUserName          '\v<\l+\@'                                       containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanCheck             '✓'                                              containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanCross             '✗'                                              containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanNull              '∅'                                              containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanQuestion          '\v(^|\s)\zs\?'                                  containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanTilde             '\v(^|\s)\zs\~\ze(\s|$)'                         containedin=Table,mkdNonListItemBlock,mkdListItemLine
syntax match   SerbanTable             '\v[│├┼┤─]'                                      containedin=mkdNonListItemBlock

highlight link SerbanUrl                Underlined
highlight link SerbanShortLink          Underlined
highlight link SerbanLinkSeparator      Identifier
highlight link SerbanLinkTitle          Constant
highlight link SerbanAbsolutePath       Special
highlight link SerbanHomePath           Underlined
highlight link SerbanCurrency           Statement
highlight link SerbanDateTime           Identifier
highlight link SerbanTodo               Special
highlight link SerbanPend               Type
highlight link SerbanDone               Statement
highlight link SerbanUserName           Statement
highlight link SerbanCheck              Statement
highlight link SerbanCross              Special
highlight link SerbanNull               Comment
highlight link SerbanQuestion           Folded
highlight link SerbanTilde              Type
highlight link SerbanTable              PreProc
