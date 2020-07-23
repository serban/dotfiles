" ------------------------------------------------------------------------------
" VUNDLE

set nocompatible                    " Don't try to be compatible with the original vi
filetype off                        " Disable filetype detection while we load Vundle
set runtimepath+=~/.vim/bundle/Vundle.vim

if filereadable(expand("/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim/syntax/lilypond.vim"))
  set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
endif

call vundle#begin()

" GitHub Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dag/vim-fish'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-mark'
Plugin 'inkarkat/vim-SearchHighlighting'
Plugin 'majutsushi/tagbar'
Plugin 'myusuf3/numbers.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'troydm/easybuffer.vim'

" macOS: UltiSnips can crash MacVim on startup if it's linked against the wrong
" Python. Not the fault of UltiSnips. See:
"   + https://github.com/SirVer/ultisnips/issues/771
"   + https://github.com/SirVer/ultisnips/issues/900
"
" If problems persist, blow away ~/.vim/bundle/ultisnips and start over with
" :PluginInstall.
Plugin 'SirVer/ultisnips'

if !filereadable("/usr/share/vim/google/google.vim")
  Plugin 'ervandew/supertab'
endif

call vundle#end()
filetype plugin indent on           " Enable filetype detection and load the appropriate plugin and indentation files

" ------------------------------------------------------------------------------
" GOOGLE

if filereadable("/usr/share/vim/google/google.vim")
  set spellfile+=~/.google.utf-8.add

  source /usr/share/vim/google/google.vim

  Glug blazedeps auto_filetypes=`['go']`
  Glug codefmt
  Glug codefmt-google
  Glug fileswitch
  Glug outline-window
  Glug youcompleteme-google

  " Disabling autoformatting for C++, protocol buffers, and Python because
  " clang-format and pyformat always format the whole file instead of just the
  " lines that have changed. See https://github.com/google/vim-codefmt/issues/9.
  " Don't need it for Go because I have the vim-go plugin installed.
  "
  " autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType c,cpp AutoFormatBuffer clang-format
  " autocmd FileType proto AutoFormatBuffer clang-format
  " autocmd FileType python AutoFormatBuffer pyformat
  autocmd FileType bzl AutoFormatBuffer buildifier
endif

" ------------------------------------------------------------------------------
" SETTINGS

colorscheme solarized

set title                           " Set the terminal title to something appropriate (like the filename being edited)
set helpheight=80                   " Set the minimum window height for help windows
set winheight=20                    " Set the minimum window height for split windows
set winwidth=86                     " Set the minimum window width for split windows
set tabpagemax=100                  " Set the maximum number of tabs that can be opened
set splitbelow                      " When horizontally splitting a window, insert the new window below the current one
set splitright                      " When vertically splitting a window, insert the new window to the right of the current one
set number                          " Show line numbers
set ruler                           " Show the cursor position in the bottom right
set showcmd                         " Show a partial command as it is being built
set laststatus=2                    " Always show the status bar (it tells us the filename)
set guioptions-=T                   " Get rid of the toolbar in gVim
set guioptions+=c                   " Don't use popup dialogs in gVim
set guicursor+=n:blinkon0           " Don't blink the cursor in normal mode
set statusline=%f\ %h%w%q%r%m%=%3v\ \ 0x%02B\ \ %Y\ \ %{SerbanCurrentWrap()}\ \ " Simple status line with virtual column, character value, filetype, and wrap settings

if has("gui_macvim")
  set guifont=Monaco:h15            " Use a good font in MacVim
endif

"set columns=114                    " Put this line in gvimrc. It makes the window wider.
"set lines=52                       " Put this line in gvimrc. It makes the window taller.
set textwidth=80
set wrapmargin=0
set colorcolumn=+1                  " Show a vertical line one character past the textwidth to help maintain line length
set numberwidth=5                   " Set the minimum gutter width so that switching back and forth between number and relativenumber isn't annoying
set nowrap                          " Don't soft-wrap lines
set linebreak                       " When soft-wrap is on (`set wrap`) then break lines at whitespace points instead of where the window boundary is
set display=lastline                " Show as much as possible of the last line in a window instead of replacing it entirely with at signs
set breakindent                     " Indent lines that are soft-wrapped with the characters in 'showbreak'
set showbreak=⧽\                    " Prepend these characters to continuations of soft-wrapped lines
set nofoldenable                    " Don't fold code
set sidescroll=16                   " When the cursor hits the end of the screen, scroll left or right by this many spaces
set sidescrolloff=10                " Always leave some space to the left and right of the cursor
set scrolloff=3                     " Always leave some lines above and below the cursor
set formatoptions=crqljt            " Auto-wrap comments, insert comment leader on <Enter>, gq formats comments, don't automatically fix long lines when entering insert mode, remove comment leaders when joining lines, hard wrap
set nojoinspaces                    " When formatting text, insert only one space at the end of a sentence.
set iskeyword+=-                    " Add hyphen to the list of characters that comprise a word
set encoding=utf-8                  " Default to UTF-8 encoding

set sessionoptions=buffers,curdir,folds,resize,tabpages,winpos,winsize  " What to preserve when saving a session

set printoptions=paper:letter       " Set the paper size for America

syntax on                           " Colors!
set hlsearch                        " Highlight search results
set incsearch                       " Search as you type
set ignorecase                      " Case insensitive when searching...
set smartcase                       " unless there's an uppercase character in the search string
set gdefault                        " Replace all occurrences on a line by default (s/old/new/g)

set spelllang=en_us                 " Use American English for spell checking
set spellfile=~/.en.utf-8.add

set listchars=tab:»\ ,trail:⚐       " Show tabs and trailing whitespace
set list

set tabstop=8                       " \t is 8 characters wide
set shiftwidth=2                    " Shift commands are 2 characters wide
set softtabstop=2                   " Indents are 2 characters wide
set expandtab                       " Only use spaces (\t will never be inserted)

set shiftround                      " Round indent to a multiple of shiftwidth for > and <, and in insert mode for CTRL-T, and CTRL-D
set autoindent                      " Keep the indentation the same when inserting a new line
"set smartindent                    " Syntax-aware indenting
set modeline                        " Modelines in files take precedent over these settings

" Don't move comment hashes to the beginning of the line when writing Python. This behavior is caused by smartindent.
inoremap # X#

set backspace=eol,indent,start      " Make life easier on crappy terminals

set mouse=a                         " Enable the mouse
set ttymouse=sgr                    " Support mouse past the 223rd column

set autochdir                       " Keep the current directory in sync with the folder containing the open file

" Enable bracketed paste inside tmux. See :help xterm-bracketed-paste
if &term =~ "screen"
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif

" ------------------------------------------------------------------------------
" PLUGIN SETTINGS

" CTRLP
let g:ctrlp_map = '<C-f>'
let g:ctrlp_match_window = 'order:ttb,min:20,max:20'
let g:ctrlp_switch_buffer = ''
let g:ctrlp_clear_cache_on_exit = 1  " NB: This calls ctrlp#clra() on exit. This clears all caches, even those of other running Vim sessions. Caches are only cleared if you invoke CtrlP during the Vim session.
let g:ctrlp_extensions = ['autoignore']

" EASYBUFFER
let g:easybuffer_sort_mode = 'n'    " Sort by buffer name, ascending

" EDITORCONFIG
let g:EditorConfig_exclude_patterns = ['.\+\.go$']  " Custom indentation for golang is set below

" NUMBERS
" I would simply call add(g:numbers_exclude, 'help') here, but g:numbers_exclude
" does not exist when this code is run. See numbers.vim for the default value.
let g:numbers_exclude = ['help', 'tagbar']

" TAGBAR
let g:tagbar_indent = 0
let g:tagbar_left = 1
let g:tagbar_show_visibility = 0
let g:tagbar_width = 60
let g:tagbar_zoomwidth = 0

" ULTISNIPS
let g:UltiSnipsExpandTrigger = '<C-Tab>'  " <Tab> works with Supertab but conflicts with YouCompleteMe
" let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-Down>'
let g:UltiSnipsJumpBackwardTrigger = '<C-Up>'

" VIM-GO
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 0    " Makes vim laggy when enabled. See https://github.com/fatih/vim-go/issues/72
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 0      " Makes vim laggy when enabled. See https://github.com/fatih/vim-go/issues/72
let g:go_updatetime = 1

" VIM-COMMENTARY
let g:commentary_map_backslash = 0  " Disable deprecated mappings

" VIM-MARK
let g:mw_no_mappings = 0
let g:mwAutoSaveMarks = 0

" DarkYellow   --> Solarized Yellow
" Red          --> Solarized Orange
" Dark Red     --> Solarized Red
" Dark Magenta --> Solarized Magenta
" Magenta      --> Solarized Violet
" Dark Blue    --> Solarized Blue
" Dark Cyan    --> Solarized Cyan
" Dark Green   --> Solarized Green
let g:mwDefaultHighlightingPalette = [
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkMagenta', 'guibg':'#d33682' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkBlue',    'guibg':'#268bd2' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkYellow',  'guibg':'#b58900' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'Magenta',     'guibg':'#6c71c4' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'Red',         'guibg':'#cb4b16' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkCyan',    'guibg':'#2aa198' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkRed',     'guibg':'#dc322f' },
\   { 'ctermfg':'White', 'guifg':'White', 'ctermbg':'DarkGreen',   'guibg':'#859900' },
\]

" YOUCOMPLETEME
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

" ------------------------------------------------------------------------------
" FUNCTIONS

function SerbanInsertModeline()
  if &expandtab
    let expandStr="et"
  else
    let expandStr="noet"
  endif

  call append(0, "# vim:" .
  \               " ts=" . &tabstop .
  \               " sw=" . &shiftwidth .
  \               " sts=" . &softtabstop .
  \               " " . expandStr)

  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Inserted modeline'
endfunction

function SerbanRemoveTrailingWhitespace()
  silent! %s/\v\s+$//g
  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Removed trailing whitespace'
endfunction

function SerbanRemoveHttpScheme()
  silent! %s,\vhttp://b/,b/,g
  silent! %s,\vhttp://cl/,cl/,g
  silent! %s,\vhttp://go/,go/,g
  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Removed http:// from shortlinks'
endfunction

function SerbanToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction

function SerbanToggleColorColumn()
  if &colorcolumn != "0"
    windo set colorcolumn=0
  else
    windo set colorcolumn=+1
  endif
endfunction

function SerbanToggleLineNumbers()
  if &number
    NumbersDisable
    set nonumber
    set norelativenumber
  else
    NumbersEnable
  endif
endfunction

" ------------------------------------------------------------------------------
" WRAP FUNCTIONS

" I like to work in four different wrap modes:
"
" * Hard Wrap - Vim automatically inserts newlines past a certain column
" * Hint Wrap - Vim shows a column guide but performs no wrapping
" * Soft Wrap - Vim shows full lines without altering the file
" *   No Wrap - Vim shows no guide and performs no wrapping
"
" These modes involve setting the following options, some of which are
" orthogonal to each other and some of which are not:
"
" * textwidth
" * formatoptions
" * colorcolumn
" * wrap
"
" When textwidth is zero, the lesser of the screen width or 79 is used to wrap
" code comments. See `:help autoformat` or `:help gq` for more.

function SerbanWrapHard()
  if &textwidth == 0
    set textwidth=80
  endif
  set formatoptions+=t
  set colorcolumn=+1
  set nowrap
endfunction

function SerbanWrapHint()
  if &textwidth == 0
    set textwidth=80
  endif
  set formatoptions-=t
  set colorcolumn=+1
  set nowrap
endfunction

function SerbanWrapSoft()
  set formatoptions-=t
  set colorcolumn=0
  set wrap
endfunction

function SerbanWrapNone()
  set formatoptions-=t
  set colorcolumn=0
  set nowrap
endfunction

function SerbanCurrentWrap()
  if &textwidth != 0 && stridx(&formatoptions, 't') != -1
    return 'HARD  ' . &textwidth
  elseif &textwidth != 0 && &colorcolumn != '0' && !&wrap
    return 'HINT  ' . &textwidth
  elseif &wrap
    return 'SOFT'
  else
    return 'NONE'
  endif
endfunction

" ------------------------------------------------------------------------------
" INDENTATION FUNCTIONS

" tabstop is the number of characters represented by a \t.
" shiftwidth is the number of characters in a shift operation like << or >>.
" softtabstop is the number of characters that a tab counts for.
" expandtab inserts only spaces when the tab key is pressed.

function SerbanIndentSpaces2()
  set tabstop=8 shiftwidth=2 softtabstop=2 expandtab
endfunction

function SerbanIndentSpaces4()
  set tabstop=8 shiftwidth=4 softtabstop=4 expandtab
endfunction

function SerbanIndentSpaces8()
  set tabstop=8 shiftwidth=8 softtabstop=8 expandtab
endfunction

function SerbanIndentTabs2()
  set tabstop=2 shiftwidth=2 softtabstop=0 noexpandtab
endfunction

function SerbanIndentTabs4()
  set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
endfunction

function SerbanIndentTabs8()
  set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endfunction

" Mix tabs and spaces so that \t is 8 characters wide but indentation is aligned
" at 4-character boundaries. Leading whitespace consists of any number of tabs
" followed by 4 spaces if the start of the line is not aligned to an 8-character
" boundary.
function SerbanIndentMixed4()
  set tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
endfunction

" ------------------------------------------------------------------------------
" EVENT HANDLERS

" Alternatively, create ~/.vim/after/ftplugin/{cpp,go}.vim
autocmd FileType cpp set commentstring=//\ \ %s iskeyword-=-
autocmd FileType go set textwidth=100 tabstop=2 shiftwidth=2 softtabstop=0 noexpandtab nolist

augroup serban-markdown
  autocmd!
  autocmd FileType markdown autocmd BufWritePre <buffer> silent call SerbanRemoveTrailingWhitespace()
augroup end

augroup serban-snippets
  autocmd!
  autocmd BufWritePre ~/snippets/*.md silent call SerbanRemoveHttpScheme()
augroup end

" ------------------------------------------------------------------------------
" ABBREVIATIONS

iabbrev td TODO(serban):

" ------------------------------------------------------------------------------
" KEY MAPPINGS

let mapleader = " "

" Disable man pages
nnoremap <unique> K <Nop>

" Disable Ex-mode
nnoremap <unique> Q  <Nop>
nnoremap <unique> gQ <Nop>
nnoremap <unique> q: <Nop>

" Arrow keys move the cursor up and down a display line instead of a physical
" line. Useful when soft-wrapping text.
nnoremap <unique> <Up>   gk
inoremap <unique> <Up>   <ESC>gka
nnoremap <unique> <Down> gj
inoremap <unique> <Down> <ESC>gja

cnoremap <unique>  <F1> <ESC>
inoremap <unique>  <F1> <ESC>
nnoremap <unique>  <F1> <ESC>
vnoremap <unique>  <F1> <ESC>
nnoremap <unique>  <F2> :call SerbanIndentSpaces2() <CR>
nnoremap <unique>  <F3> :call SerbanIndentTabs2() <CR>
nnoremap <unique>  <F4> :call SerbanIndentSpaces4() <CR>
nnoremap <unique>  <F5> :call SerbanIndentTabs4() <CR>
nnoremap <unique>  <F8> :call SerbanIndentSpaces8() <CR>
nnoremap <unique>  <F9> :call SerbanIndentTabs8() <CR>
nnoremap <unique> <F12> :call SerbanIndentMixed4() <CR>

nnoremap <unique> <C-a> :botright vsplit <CR>
nnoremap <unique> <C-b> :tabnew <CR>
nnoremap <unique> <C-c> :close <CR>
nnoremap <unique> <C-g> :split <CR>
nnoremap <unique> <C-h> :wincmd h <CR>
nnoremap <unique> <C-j> :wincmd j <CR>
nnoremap <unique> <C-k> :wincmd k <CR>
nnoremap <unique> <C-l> :wincmd l <CR>
nnoremap <unique> <C-n> :tabnext <CR>
nnoremap <unique> <C-p> :tabprevious <CR>
nnoremap <unique> <C-q> :quitall <CR>
nnoremap <unique> <C-s> :update <CR>
inoremap <unique> <C-s> <ESC>:update <CR>
nnoremap <unique> <C-x> :bp <Bar> sp <Bar> bn <Bar> bd <CR>

" TODO(serban): Does not work in tmux. See:
" - https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
" - https://stackoverflow.com/questions/38133250/cannot-get-control-arrow-keys-working-in-vim-through-tmux
nnoremap <unique> <C-Left>  :tabmove -1 <CR>
nnoremap <unique> <C-Right> :tabmove +1 <CR>

nnoremap <unique> <Leader>b :FileswitchEditBUILD <CR>
nnoremap <unique> <Leader>c :FileswitchEditCC <CR>
nnoremap <unique> <Leader>d :YcmCompleter GoToDeclaration <CR>
nnoremap <unique> <Leader>e :EasyBuffer <CR>
nnoremap <unique> <Leader>f :YcmCompleter GoToDefinition <CR>
nnoremap <unique> <Leader>g :FileswitchEditGo <CR>
nnoremap <unique> <Leader>h :FileswitchEditH <CR>
nnoremap <unique> <Leader>i :GoImports <CR>
nnoremap <unique> <Leader>j :FileswitchEditJava <CR>
nnoremap <unique> <Leader>k :CtrlPBuffer <CR>
nnoremap <unique> <Leader>l :Marks <CR>
    nmap <unique> <Leader>m <Plug>MarkSet
    nmap <unique> <Leader>n <Plug>MarkAllClear
nnoremap <unique> <Leader>o :GoogleOutlineWindow <CR>
nnoremap <unique> <Leader>p :FileswitchEditPy <CR>
nnoremap <unique> <Leader>t :FileswitchEditTest <CR>
nnoremap <unique> <Leader>u :FileswitchEditUnitTest <CR>
nnoremap <unique> <Leader>z :nohlsearch <CR>

nnoremap <unique> <Leader>at :Tabularize /<Bar><CR>

nnoremap <unique> <Leader>in :let g:clang_include_fixer_query_mode=0<CR>:pyfile /usr/lib/clang-include-fixer/clang-include-fixer.py<CR>
nnoremap <unique> <Leader>iq :let g:clang_include_fixer_query_mode=1<CR>:pyfile /usr/lib/clang-include-fixer/clang-include-fixer.py<CR>

nnoremap <unique> <Leader>rh :call SerbanRemoveHttpScheme() <CR>
nnoremap <unique> <Leader>rw :call SerbanRemoveTrailingWhitespace() <CR>

nnoremap <unique> <Leader>sb :call SerbanToggleBackground() <CR>
nnoremap <unique> <Leader>sc :call SerbanToggleColorColumn() <CR>
nnoremap <unique> <Leader>sn :call SerbanToggleLineNumbers() <CR>
nnoremap <unique> <Leader>ss :set spell! <CR>
nnoremap <unique> <Leader>st :TagbarToggle <CR>

nnoremap <unique> <Leader>wh :call SerbanWrapHard() <CR>
nnoremap <unique> <Leader>wi :call SerbanWrapHint() <CR>
nnoremap <unique> <Leader>wo :call SerbanWrapSoft() <CR>
nnoremap <unique> <Leader>wn :call SerbanWrapNone() <CR>

" Glug corpweb
" nnoremap <unique> <Leader>cs :CorpWebCs <C-R>=expand('<cword>')<CR><CR>
" nnoremap <unique> <Leader>cf :CorpWebCsFile <CR>
" nnoremap <unique> <Leader>cd :CorpWebDocFindFile <CR>
" nnoremap <unique> <Leader>cl :CorpWebCritiqueCl <CR>

" ------------------------------------------------------------------------------
" LOCAL SETTINGS

if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
