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

syntax match   SerbanAcronym             '\v<\u+s?>'        transparent contains=@NoSpell containedin=ALL

syntax match   SerbanUrl                 '\v<https?://\S+>'                               containedin=Table nextgroup=SerbanLinkSeparator
syntax match   SerbanShortLink           '\v<(b|cl|g|go|google3|g3doc|omg|yaqs)/\S+>'     containedin=Table nextgroup=SerbanLinkSeparator
syntax match   SerbanLinkSeparator       '\v - '                                                            nextgroup=SerbanLinkTitle     contained
syntax match   SerbanLinkTitle           '\v[^│]+\ze(│|$)'                                                                                contained
syntax match   SerbanAbsolutePath        '\v(^|\s)\zs/\S+>'                               containedin=Table
syntax match   SerbanHomePath            '\v(^|\s)\zs\~/\S+>'                             containedin=Table
syntax match   SerbanCurrency            '\v(^|\s)\zs(\$|€)\s*(\d|,)+(\.\d\d)?>'          containedin=Table
syntax match   SerbanCommit              '\v<[0-9a-f]{7,64}>'                             containedin=Table
syntax match   SerbanDateTime            '\v<\d{4}-\d{2}-\d{2}( \d{2}:\d{2}(:\d{2})?)?>'  containedin=Table
syntax match   SerbanTime                '\v<\d{2}:\d{2}>'                                containedin=Table
syntax match   SerbanHoursMinutesSeconds '\v<\d+h(\d{2}m(\d{2}s)?)?>'                     containedin=Table
syntax match   SerbanMinutesSeconds      '\v<\d+m(\d{2}s)?>'                              containedin=Table
syntax match   SerbanSeconds             '\v<\d+s>'                                       containedin=Table
syntax match   SerbanPageNumber          '\v<p\d+>'                                       containedin=Table
syntax match   SerbanSymbol              '\v<✝\S+>'                                       containedin=Table
syntax match   SerbanFunction            '\v<\S+\(\)'                                     containedin=Table
syntax match   SerbanUserName            '\v<\l+\@'                                       containedin=Table
syntax match   SerbanNotaBene            '\v<NB:'                                         containedin=Table
syntax match   SerbanTodo                '\v<TODO(\(serban\))?:?'                         containedin=Table
syntax match   SerbanPend                '\v<PEND(\(serban\))?:?'                         containedin=Table
syntax match   SerbanDone                '\v<DONE(\(serban\))?:?'                         containedin=Table
syntax match   SerbanDot                 '·'                                              containedin=Table
syntax match   SerbanCheck               '✓'                                              containedin=Table
syntax match   SerbanCross               '✗'                                              containedin=Table
syntax match   SerbanNull                '∅'                                              containedin=Table
syntax match   SerbanQuestion            '\v(^|\s)\zs\?'                                  containedin=Table
syntax match   SerbanTilde               '\v(^|\s)\zs\~\ze(\s|$)'                         containedin=Table
syntax match   SerbanFootnoteReference   '\v｢\S*｣'                                        containedin=Table
syntax match   SerbanTable               '\v[│├┼┤─]'

syntax match   SerbanDate                '\v<(Mon|Tue|Wed|Thu|Fri|Sat|Sun) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{2}( \d{4})?>' containedin=Table

highlight link SerbanUrl                  SerbanViolet
highlight link SerbanShortLink            SerbanViolet
highlight link SerbanLinkSeparator        SerbanBlue
highlight link SerbanLinkTitle            SerbanCyan
highlight link SerbanAbsolutePath         SerbanRed
highlight link SerbanHomePath             SerbanViolet
highlight link SerbanCurrency             SerbanGreen
highlight link SerbanCommit               SerbanCyan
highlight link SerbanDateTime             SerbanBlue
highlight link SerbanTime                 SerbanCyan
highlight link SerbanHoursMinutesSeconds  SerbanYellow
highlight link SerbanMinutesSeconds       SerbanYellow
highlight link SerbanSeconds              SerbanYellow
highlight link SerbanPageNumber           SerbanCyan
highlight link SerbanSymbol               SerbanMagenta
highlight link SerbanFunction             SerbanGreen
highlight link SerbanUserName             SerbanGreen
highlight link SerbanNotaBene             SerbanYellow
highlight link SerbanTodo                 SerbanRed
highlight link SerbanPend                 SerbanYellow
highlight link SerbanDone                 SerbanGreen
highlight link SerbanDot                  SerbanYellow
highlight link SerbanCheck                SerbanGreen
highlight link SerbanCross                SerbanRed
highlight link SerbanNull                 SerbanGray
highlight link SerbanQuestion             SerbanViolet
highlight link SerbanTilde                SerbanYellow
highlight link SerbanFootnoteReference    SerbanOrange
highlight link SerbanTable                SerbanOrange

highlight link SerbanDate                 SerbanViolet
