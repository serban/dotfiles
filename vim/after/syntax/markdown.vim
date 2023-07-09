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

syntax match   SerbanAcronym           '\v<\u+s?>'        transparent contains=@NoSpell containedin=ALL

syntax match   SerbanUrl               '\v<https?://\S+>'                               containedin=Table nextgroup=SerbanLinkSeparator
syntax match   SerbanShortLink         '\v<(b|cl|g|go|google3|g3doc|omg|yaqs)/\S+>'     containedin=Table nextgroup=SerbanLinkSeparator
syntax match   SerbanLinkSeparator     '\v - '                                                            nextgroup=SerbanLinkTitle     contained
syntax match   SerbanLinkTitle         '\v[^│]+\ze(│|$)'                                                                                contained
syntax match   SerbanAbsolutePath      '\v(^|\s)\zs/\S+>'                               containedin=Table
syntax match   SerbanHomePath          '\v(^|\s)\zs\~/\S+>'                             containedin=Table
syntax match   SerbanCurrency          '\v(^|\s)\zs(\$|€)\s*(\d|,)+(\.\d\d)?>'          containedin=Table
syntax match   SerbanDateTime          '\v<\d{4}-\d{2}-\d{2}( \d{2}:\d{2}(:\d{2})?)?>'  containedin=Table
syntax match   SerbanTodo              '\v<TODO(\(serban\))?:?'                         containedin=Table
syntax match   SerbanPend              '\v<PEND(\(serban\))?:?'                         containedin=Table
syntax match   SerbanDone              '\v<DONE(\(serban\))?:?'                         containedin=Table
syntax match   SerbanUserName          '\v<\l+\@'                                       containedin=Table
syntax match   SerbanCheck             '✓'                                              containedin=Table
syntax match   SerbanCross             '✗'                                              containedin=Table
syntax match   SerbanNull              '∅'                                              containedin=Table
syntax match   SerbanQuestion          '\v(^|\s)\zs\?'                                  containedin=Table
syntax match   SerbanTilde             '\v(^|\s)\zs\~\ze(\s|$)'                         containedin=Table
syntax match   SerbanTable             '\v[│├┼┤─]'

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
