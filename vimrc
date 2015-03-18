" vim:set ts=8 sw=2 sts=2 et:

" ------------------------------------------------------------------------------
" VUNDLE

set nocompatible                    " Don't try to be compatible with the original vi
filetype off                        " Disable filetype detection while we load Vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" GitHub Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
" Plugin 'godlygeek/tabular'
" Plugin 'kien/ctrlp.vim'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'myusuf3/numbers.vim'
" Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-unimpaired'
Plugin 'troydm/easybuffer.vim'

if !filereadable(expand('~/.vimrc_google'))
  Plugin 'ervandew/supertab'
endif

call vundle#end()
filetype plugin on                  " Enable filetype detection and load the appropriate plugin files

" ------------------------------------------------------------------------------
" SETTINGS

set title                           " Set the terminal title to something appropriate (like the filename being edited)
set background=light                " Set the default colors to look good on white backgrounds. See below for toggling this.
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

if has("gui_macvim")
  set guifont=Monaco:h15            " Use a good font in MacVim
endif

"set columns=114                    " Put this line in gvimrc. It makes the window wider.
"set lines=52                       " Put this line in gvimrc. It makes the window taller.
set textwidth=80
set colorcolumn=+1                  " Show a vertical line one character past the textwidth to help maintain line length
set numberwidth=5                   " Set the minimum gutter width so that switching back and forth between number and relativenumber isn't annoying
set nowrap                          " Don't soft-wrap lines
set nofoldenable                    " Don't fold code
set sidescroll=16                   " When the cursor hits the end of the screen, scroll left or right by this many spaces
set sidescrolloff=10                " Always leave some space to the left and right of the cursor
set scrolloff=3                     " Always leave some lines above and below the cursor
set formatoptions=crqlj             " Auto-wrap comments, insert comment leader on <Enter>, gq formats comments, don't automatically fix long lines when entering insert mode, remove comment leaders when joining lines
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

set listchars=tab:»\ ,trail:⚐       " Show tabs and trailing whitespace
set list

set tabstop=8                       " \t is 8 characters wide
set shiftwidth=2                    " Shift commands are 2 characters wide
set softtabstop=2                   " Indents are 2 characters wide
set expandtab                       " Only use spaces (\t will never be inserted)

set shiftround                      " Round indent to a multiple of shiftwidth for > and <, and in insert mode for CTRL-T, and CTRL-D
set autoindent                      " Keep the indentation the same when inserting a new line
set smartindent                     " Syntax-aware indenting
set modeline                        " Modelines in files take precedent over these settings

" Don't move comment hashes to the beginning of the line when writing Python
inoremap # X#

set backspace=eol,indent,start      " Make life easier on crappy terminals

set autochdir                       " Keep the current directory in sync with the folder containing the open file

" ------------------------------------------------------------------------------
" PLUGIN SETTINGS

" EASYBUFFER
let g:easybuffer_sort_mode = 'n'    " Sort by buffer name, ascending

" VIM-GO
" let g:go_fmt_command = 'goimports'  " Currently broken. See https://github.com/fatih/vim-go/issues/217
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1

" VIM-COMMENTARY
let g:commentary_map_backslash = 0  " Disable deprecated mappings

" YOUCOMPLETEME
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1

" ------------------------------------------------------------------------------
" ABBREVIATIONS

iabbrev TODO: TODO(serban):

inoremap <unique> ## # ------------------------------------------------------------------------------<ESC>o

" ------------------------------------------------------------------------------
" CSOPE

" if has("cscope")
"   if filereadable("cscope.out")   " Look in local directory first
"     cscope add cscope.out
"   elseif $CSCOPE_DB != ""         " Then look at environmental variable
"     cscope add $CSCOPE_DB
"   endif
"
"   set cscopeverbose
"   set cscopetag                   " When pressing CTRL-], search cscope instead of ctags
"   set csto=0                      " Search cscope database before ctags database
"   set cscopepathcomp=0            " Show the entire path of a file in cscope listings
"
"   " The following maps all invoke one of the following cscope search types:
"   "
"   "   's'   symbol:   find all references to the token under cursor
"   "   'g'   global:   find global definition(s) of the token under cursor
"   "   'c'   calls:    find all calls to the function name under cursor
"   "   't'   text:     find all instances of the text under cursor
"   "   'e'   egrep:    egrep search for the word under cursor
"   "   'f'   file:     open the filename under cursor
"   "   'i'   includes: find files that include the filename under cursor
"   "   'd'   called:   find functions that function under cursor calls
"
"   nnoremap <unique> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>      " Find this C symbol
"   nnoremap <unique> <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>      " Find this definition
"   nnoremap <unique> <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>      " Find functions called by this function
"   nnoremap <unique> <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>      " Find functions calling this function
"   nnoremap <unique> <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>      " Find this text string
"   nnoremap <unique> <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>      " Find this egrep pattern
"   nnoremap <unique> <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>      " Find this file
"   nnoremap <unique> <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>    " Find files #including this file
"
"   nnoremap <unique> <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>     " Find this C symbol
"   nnoremap <unique> <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>     " Find this definition
"   nnoremap <unique> <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>     " Find functions called by this function
"   nnoremap <unique> <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>     " Find functions calling this function
"   nnoremap <unique> <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>     " Find this text string
"   nnoremap <unique> <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>     " Find this egrep pattern
"   nnoremap <unique> <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>     " Find this file
"   nnoremap <unique> <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   " Find files #including this file
" endif

" ------------------------------------------------------------------------------
" FUNCTIONS

" TODO(serban): Figure out why this doesn't work
function HighlightWordUnderCursor()
  let @/ = "\<".expand("<cword>")."\>"
  set hlsearch
endfunction

function InsertModeline()
  if &expandtab
    let expandStr="et"
  else
    let expandStr="noet"
  endif

  call append(0, "# vim:set" .
  \               " ts=" . &tabstop .
  \               " sw=" . &shiftwidth .
  \               " sts=" . &softtabstop .
  \               " " . expandStr . ":")

  echo 'Inserted modeline on the first line'
endfunction

function RemoveTrailingWhitespace()
  silent! %s/\v\s+$//g
  echo 'Removed trailing whitespace'
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

" ------------------------------------------------------------------------------
" KEY MAPPINGS

let mapleader = " "

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
"   - <C-b>
"   * <C-c>
"   + <C-d>
"   + <C-e>
"   - <C-f>
"   - <C-g>
"   * <C-h>
"   + <C-i>
"   * <C-j>
"   * <C-k>
"   * <C-l>
"   * <C-m>
"   * <C-n>
"   + <C-o>
"   * <C-p>
"   - <C-q>  Must set `stty -ixon` for this to work
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

" Open a new window
nnoremap <unique> <C-m> :vsplit <CR>

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

" Move the current tab to the left
nnoremap <unique> <Leader>j :tabmove -1 <CR>

" Move the current tab to the right
nnoremap <unique> <Leader>k :tabmove +1 <CR>

" Highlight the word under the cursor
" nnoremap <unique> <Leader>y :let @/ = '\<'.expand('<cword>').'\>' \| set hlsearch<C-M>
nnoremap <unique> <Leader>y *<C-o>

" Clear the highlighting for the current search
nnoremap <unique> <Leader>n :nohlsearch <CR>

nnoremap <unique> <Leader>G :YcmCompleter GoToDeclaration <CR>
nnoremap <unique> <Leader>g :YcmCompleter GoToDefinition <CR>
nnoremap <unique> <Leader>i :GoImports <CR>
nnoremap <unique> <Leader>e :EasyBuffer <CR>
nnoremap <unique> <Leader>m :call InsertModeline() <CR>
nnoremap <unique> <Leader>s :set spell! <CR>
nnoremap <unique> <Leader>v :call ThreeSplit() <CR>
nnoremap <unique> <Leader>w :call RemoveTrailingWhitespace() <CR>
nnoremap <unique> <Leader>sb :call ToggleBackground() <CR>
nnoremap <unique> <Leader>sc :call ToggleColorcolumn() <CR>

" ------------------------------------------------------------------------------
" EVENT HANDLERS

autocmd FileType go :set tabstop=2 shiftwidth=2 softtabstop=0 noexpandtab nolist

autocmd FileType cpp :set commentstring=//\ \ %s

autocmd FileType gitcommit :set formatoptions+=t            " Auto-wrap text for Git commits
autocmd FileType tex :set formatoptions+=t                  " Auto-wrap text for LaTeX files
autocmd FileType text :set formatoptions+=t                 " Auto-wrap text for plain text files

" ------------------------------------------------------------------------------
" GOOGLE-SPECIFIC

if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim

  Glug codefmt
  Glug codefmt-google auto_filetypes+=blazebuild,clang-format
  Glug corpweb
  Glug fileswitch plugin[mappings]
  Glug g4
  Glug outline-window
  Glug relatedfiles plugin[mappings]
  Glug youcompleteme-google

  " Auto-wrap text for `g4 change`
  autocmd FileType piperspec :set formatoptions+=t

  nnoremap <unique> <Leader>d :G4Diff <CR>
  nnoremap <unique> <Leader>o :GoogleOutlineWindow <CR>

  nnoremap <unique> <Leader>b :FileswitchEditBUILD <CR>
  nnoremap <unique> <Leader>h :FileswitchEditH <CR>
  nnoremap <unique> <Leader>c :FileswitchEditCC <CR>
  nnoremap <unique> <Leader>t :FileswitchEditTest <CR>
  nnoremap <unique> <Leader>u :FileswitchEditUnitTest <CR>

  nnoremap <unique> <Leader>cs :CorpWebCs <C-R>=expand('<cword>')<CR><CR>
  nnoremap <unique> <Leader>cf :CorpWebCsFile <CR>
endif

" ------------------------------------------------------------------------------
" LOCAL SETTINGS

if filereadable(expand("~/.vimrc_google"))
  source ~/.vimrc_google
endif

if filereadable(expand("~/.vimrc_local"))
  source ~/.vimrc_local
endif
