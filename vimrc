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
" Plugin 'inkarkat/vim-SearchHighlighting'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'myusuf3/numbers.vim'
" Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-markdown'
" Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-unimpaired'
Plugin 'troydm/easybuffer.vim'

" gLinux: As of November 18, 2019, the version of Vim on gLinux is not built
" with support for Python 3, so keep UltiSnips pinned to tag 3.2. The next
" commit, d2f42d6b43902e5b2ef7bfca2579ccb6cc9f52c0, drops support for Python 2.
" Follow along at b/71991856.
"
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
set statusline=%f\ %h%w%q%r%m%=%3v\ \ 0x%02B\ \ %Y\ \ %{CurrentWrap()}\ \ " Simple status line with virtual column, character value, filetype, and wrap settings

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
let g:ctrlp_map = '<Leader>f'
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
let g:numbers_exclude = ['help']

" ULTISNIPS
let g:UltiSnipsExpandTrigger = '<C-Tab>'  " <Tab> works with Supertab but conflicts with YouCompleteMe
" let g:UltiSnipsListSnippets = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-f>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

" VIM-GO
let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 0    " Makes vim laggy when enabled. See https://github.com/fatih/vim-go/issues/72
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 0      " Makes vim laggy when enabled. See https://github.com/fatih/vim-go/issues/72

" VIM-COMMENTARY
let g:commentary_map_backslash = 0  " Disable deprecated mappings

" VIM-MARK
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
" ABBREVIATIONS

iabbrev TODO: TODO(serban):

" ------------------------------------------------------------------------------
" FUNCTIONS

function InsertModeline()
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

function RemoveTrailingWhitespace()
  silent! %s/\v\s+$//g
  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Removed trailing whitespace'
endfunction

function RemoveHttpScheme()
  silent! %s,\vhttp://b/,b/,g
  silent! %s,\vhttp://cl/,cl/,g
  silent! %s,\vhttp://go/,go/,g
  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Removed http:// from shortlinks'
endfunction

function ThreeSplit()
  vsplit
  vsplit
endfunction

function ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction

function ToggleColorcolumn()
  if &colorcolumn != "0"
    windo set colorcolumn=0
  else
    windo set colorcolumn=+1
  endif
endfunction

function DisableLineNumbers()
  NumbersDisable
  set nonumber
  set norelativenumber
  echom strftime('[%Y-%m-%d %H:%M:%S] ') . 'Disabled line numbers'
endfunction

" ------------------------------------------------------------------------------
" WRAP FUNCTIONS

" I like to work in three different wrap modes:
"
" * Hard Wrap (Default)
" * Soft Wrap
" * No Wrap
"
" These modes involve setting the following options, some of which are
" orthogonal to each other and some of which are not:
"
" * textwidth
" * formatoptions
" * colorcolumn
" * wrap

function EnableHardWrap()
  if &textwidth == 0
    set textwidth=80
  endif
  set formatoptions+=t
  set colorcolumn=+1
  set nowrap
endfunction

function EnableSoftWrap()
  set formatoptions-=t
  set colorcolumn=0
  set wrap
endfunction

function DisableWrap()
  set formatoptions-=t
  set colorcolumn=0
  set nowrap
endfunction

function CurrentWrap()
  if &textwidth != 0 && stridx(&formatoptions, 't') != -1
    return 'HARD ' . &textwidth
  elseif &wrap
    return 'SOFT'
  else
    return 'NONE'
  endif
endfunction

" ------------------------------------------------------------------------------
" KEY MAPPINGS

let mapleader = " "

" Disable man pages.
nnoremap <unique> K <Nop>

" Disable Ex-mode.
nnoremap <unique> Q <Nop>
nnoremap <unique> gQ <Nop>
nnoremap <unique> q: <Nop>

" Remap F1 to ESCAPE for keyboards where the Escape key is far away.
cnoremap <unique> <F1> <ESC>
inoremap <unique> <F1> <ESC>
nnoremap <unique> <F1> <ESC>
vnoremap <unique> <F1> <ESC>

" Tabstop is the number of characters represented by a \t
" Shiftwidth is the amount of characters in a shift operation like << or >>
" Softtabstop is the number of characters that a tab counts for
" Expandtab will insert only spaces when the tab key is pressed

" \t is 8 characters wide. Indents are 2 characters wide. Only use spaces.
nnoremap <unique> <F2> :set tabstop=8 shiftwidth=2 softtabstop=2 expandtab

" \t is 2 characters wide. Only use \t.
nnoremap <unique> <F3> :set tabstop=2 shiftwidth=2 softtabstop=0 noexpandtab

" \t is 8 characters wide. Indents are 4 characters wide. Only use spaces.
nnoremap <unique> <F4> :set tabstop=8 shiftwidth=4 softtabstop=4 expandtab

" \t is 4 characters wide. Only use \t.
nnoremap <unique> <F5> :set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

" \t is 8 characters wide. Indents are 8 characters wide. Only use spaces.
nnoremap <unique> <F8> :set tabstop=8 shiftwidth=8 softtabstop=8 expandtab

" \t is 8 characters wide. Only use \t.
nnoremap <unique> <F9> :set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" \t is 8 characters wide. Indents are 4 characters wide. Mix tabs and spaces.
"
" Mix tabs and spaces so that tabs are 8 characters wide but indentation is
" 4 spaces wide. Thus, whitespace will consist of any number of tabs
" followed by four spaces if the start of the line is not aligned to an
" eight-charater boundary.
"nnoremap <F12> :set tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab

" ------------------------------------------------------------------------------
" CONTROL KEYS

" + Indicates that I use the built-in command.
" - Indicates that I don't use the built-in command.
" * Indicatates I've remapped it below.

"   * <C-a>
"   * <C-b>  Mapped by UltiSnips above
"   * <C-c>
"   + <C-d>
"   + <C-e>
"   * <C-f>  Mapped by UltiSnips above
"   * <C-g>
"   * <C-h>
"   + <C-i>
"   * <C-j>
"   * <C-k>
"   * <C-l>
"   * <C-m>
"   * <C-n>
"   + <C-o>
"   * <C-p>
"   * <C-q>  Must set `stty -ixon` for this to work
"   + <C-r>
"   * <C-s>  Must set `stty -ixon` for this to work
"   + <C-t>
"   + <C-u>
"   + <C-v>
"   + <C-w>
"   * <C-x>
"   + <C-y>
"   + <C-z>

" Write the file if it has been modified
nnoremap <unique> <C-s> :update <CR>
inoremap <unique> <C-s> <ESC>:update <CR>

" Open a new window at the far right and full height of the Vim window
" TODO(serban): <C-m> is the same as <Enter> (ugh!)
nnoremap <unique> <C-m> :botright vsplit <CR>

" Delete buffer without closing window
nnoremap <unique> <C-q> :bp <Bar> sp <Bar> bn <Bar> bd <CR>

" Open a new window
nnoremap <unique> <C-g> :split <CR>

" Switch to the window to the left
nnoremap <unique> <C-h> :wincmd h <CR>

" Switch to the window below
nnoremap <unique> <C-j> :wincmd j <CR>

" Switch to the window above
nnoremap <unique> <C-k> :wincmd k <CR>

" Switch to the window to the right
nnoremap <unique> <C-l> :wincmd l <CR>

" Close the current window
nnoremap <unique> <C-c> :close <CR>

" Open a new tab
nnoremap <unique> <C-a> :tabedit <CR>

" Switch to the previous tab
nnoremap <unique> <C-p> :tabprevious <CR>

" Switch to the next tab
nnoremap <unique> <C-n> :tabnext <CR>

" Close the current tab
nnoremap <unique> <C-x> :tabclose <CR>

" Arrow keys move the cursor up and down a display line instead of a physical
" line. Useful when soft-wrapping text.
nnoremap <unique> <Up> gk
inoremap <unique> <Up> <ESC>gka
nnoremap <unique> <Down> gj
inoremap <unique> <Down> <ESC>gja

" Move the current tab to the left
nnoremap <unique> <Leader>j :tabmove -1 <CR>

" Move the current tab to the right
nnoremap <unique> <Leader>k :tabmove +1 <CR>

" Clear the highlighting for the current search
nnoremap <unique> <Leader>z :nohlsearch <CR>

nnoremap <unique> <Leader>G :YcmCompleter GoToDeclaration <CR>
nnoremap <unique> <Leader>g :YcmCompleter GoToDefinition <CR>
nnoremap <unique> <Leader>i :GoImports <CR>
nnoremap <unique> <Leader>e :EasyBuffer <CR>
nnoremap <unique> <Leader>q :CtrlPBuffer <CR>
nnoremap <unique> <Leader>p :call RemoveHttpScheme() <CR>
nnoremap <unique> <Leader>s :set spell! <CR>
nnoremap <unique> <Leader>v :call ThreeSplit() <CR>
nnoremap <unique> <Leader>w :call RemoveTrailingWhitespace() <CR>
nnoremap <unique> <Leader>sm :call InsertModeline() <CR>
nnoremap <unique> <Leader>sb :call ToggleBackground() <CR>
nnoremap <unique> <Leader>sc :call ToggleColorcolumn() <CR>
nnoremap <unique> <Leader>sh :call EnableHardWrap() <CR>
nnoremap <unique> <Leader>ss :call EnableSoftWrap() <CR>
nnoremap <unique> <Leader>sn :call DisableWrap() <CR>

" ------------------------------------------------------------------------------
" EVENT HANDLERS

autocmd FileType go :set tabstop=2 shiftwidth=2 softtabstop=0 noexpandtab nolist
autocmd FileType cpp :set commentstring=//\ \ %s
autocmd FileType cpp :set iskeyword-=-

augroup serban-markdown
  autocmd!
  autocmd FileType markdown autocmd BufWritePre <buffer> silent call RemoveTrailingWhitespace()
augroup end

augroup serban-snippets
  autocmd!
  autocmd BufWritePre ~/snippets/*.md silent call RemoveHttpScheme()
augroup end

" ------------------------------------------------------------------------------
" GOOGLE-SPECIFIC

if filereadable("/usr/share/vim/google/google.vim")
  set spellfile+=~/.google.utf-8.add

  source /usr/share/vim/google/google.vim

  Glug codefmt
  Glug codefmt-google
  Glug corpweb
  Glug fileswitch plugin[mappings]
  Glug g4
  Glug outline-window
  " Glug relatedfiles plugin[mappings]
  Glug youcompleteme-google

  autocmd FileType bzl AutoFormatBuffer buildifier

  " Disabling autoformatting for C++, protocol buffers, and Python because
  " clang-format and pyformat always format the whole file instead of just the
  " lines that have changed. See https://github.com/google/vim-codefmt/issues/9.
  "
  " autocmd FileType c,cpp AutoFormatBuffer clang-format
  " autocmd FileType proto AutoFormatBuffer clang-format
  " autocmd FileType python AutoFormatBuffer pyformat

  " I shouldn't need this since I have the vim-go plugin.
  " autocmd FileType go AutoFormatBuffer gofmt

  nnoremap <unique> <Leader>d :G4Diff <CR>
  nnoremap <unique> <Leader>o :GoogleOutlineWindow <CR>

  nnoremap <unique> <Leader>b :FileswitchEditBUILD <CR>
  nnoremap <unique> <Leader>h :FileswitchEditH <CR>
  nnoremap <unique> <Leader>c :FileswitchEditCC <CR>
  nnoremap <unique> <Leader>t :FileswitchEditTest <CR>
  nnoremap <unique> <Leader>u :FileswitchEditUnitTest <CR>

  nnoremap <unique> <Leader>cs :CorpWebCs <C-R>=expand('<cword>')<CR><CR>
  nnoremap <unique> <Leader>cf :CorpWebCsFile <CR>
  nnoremap <unique> <Leader>cd :CorpWebDocFindFile <CR>
  nnoremap <unique> <Leader>cl :CorpWebCritiqueCl <CR>

  nnoremap <unique> <Leader>in :let g:clang_include_fixer_query_mode=0<CR>:pyfile /usr/lib/clang-include-fixer/clang-include-fixer.py<CR>
  nnoremap <unique> <Leader>iq :let g:clang_include_fixer_query_mode=1<CR>:pyfile /usr/lib/clang-include-fixer/clang-include-fixer.py<CR>
endif

" ------------------------------------------------------------------------------
" LOCAL SETTINGS

if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
