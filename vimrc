" vim:set ts=8 sw=4 sts=4 et:

" ------------------------------------------------------------------------------
" VUNDLE

set nocompatible                    " Don't try to be compatible with the original vi
filetype off                        " Disable filetype detection while we load Vundle
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" GitHub Plugins
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'myusuf3/numbers.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'troydm/easybuffer.vim'

filetype plugin on                  " Enable filetype detection and load the appropriate plugin files

" ------------------------------------------------------------------------------
" SETTINGS

set title                           " Set the terminal title to something appropriate (like the filename being edited)
set background=light                " Set the default colors to look good on white backgrounds. See below for toggling this.
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
    set guifont=Monaco:h15          " Use a good font in MacVim
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
set formatoptions=crql              " Auto-wrap comments, insert comment leader on <Enter>, gq formats comments, don't automatically fix long lines when entering insert mode
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
"setlocal spell spelllang=en_us

set listchars=tab:»\ ,trail:⚐       " Show tabs and trailing whitespace
set list

set tabstop=8                       " \t is 8 characters wide
set shiftwidth=4                    " Shift commands are 4 characters wide
set softtabstop=4                   " Indents are 4 characters wide
set expandtab                       " Only use spaces (\t will never be inserted)

set autoindent                      " Keep the indentation the same when inserting a new line
set smartindent                     " Syntax-aware indenting
set modeline                        " Modelines in files take precedent over these settings

" Don't move comment hashes to the beginning of the line when writing Python
inoremap # X#

set backspace=eol,indent,start      " Make life easier on crappy terminals

set autochdir                       " Keep the current directory in sync with the folder containing the open file

" ------------------------------------------------------------------------------
" ABBREVIATIONS

abbreviate TODO: TODO(serban):

inoremap ## # ------------------------------------------------------------------------------<ESC>o
inoremap %% % ------------------------------------------------------------------------------<ESC>o
inoremap !! <!-- ----------------------------------------------------------------------- --><ESC>o
inoremap ** /* -------------------------------------------------------------------------- */<ESC>o
inoremap /// // -----------------------------------------------------------------------------<ESC>o

" ------------------------------------------------------------------------------
" CSOPE

if has("cscope")
    if filereadable("cscope.out")   " Look in local directory first
        cscope add cscope.out
    elseif $CSCOPE_DB != ""         " Then look at environmental variable
        cscope add $CSCOPE_DB
    endif

    set cscopeverbose
    set cscopetag                   " When pressing CTRL-], search cscope instead of ctags
    set csto=0                      " Search cscope database before ctags database
    set cscopepathcomp=0            " Show the entire path of a file in cscope listings

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol:   find all references to the token under cursor
    "   'g'   global:   find global definition(s) of the token under cursor
    "   'c'   calls:    find all calls to the function name under cursor
    "   't'   text:     find all instances of the text under cursor
    "   'e'   egrep:    egrep search for the word under cursor
    "   'f'   file:     open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called:   find functions that function under cursor calls

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>      " Find this C symbol
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>      " Find this definition
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>      " Find functions called by this function
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>      " Find functions calling this function
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>      " Find this text string
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>      " Find this egrep pattern
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>      " Find this file
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>    " Find files #including this file

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>     " Find this C symbol
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>     " Find this definition
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>     " Find functions called by this function
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>     " Find functions calling this function
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>     " Find this text string
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>     " Find this egrep pattern
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>     " Find this file
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   " Find files #including this file
endif

" ------------------------------------------------------------------------------
" FUNCTIONS

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
endfunction

function RemoveTrailingWhitespace()
    silent! %s/\v\s+$//g
    echo 'Trailing whitespace removed'
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

" Tabstop is the number of characters represented by a \t
" Shiftwidth is the amount of characters in a shift operation like << or >>
" Softtabstop is the number of characters that a tab counts for
" Expandtab will insert only spaces when the tab key is pressed

" \t is 8 characters wide. Indents are 2 characters wide. Only use spaces.
nnoremap <F2> :set tabstop=8 shiftwidth=2 softtabstop=2 expandtab

" \t is 8 characters wide. Indents are 4 characters wide. Only use spaces. (Default)
nnoremap <F4> :set tabstop=8 shiftwidth=4 softtabstop=4 expandtab

" \t is 4 characters wide. Only use \t.
nnoremap <F5> :set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

" \t is 8 characters wide. Indents are 8 characters wide. Only use spaces.
nnoremap <F8> :set tabstop=8 shiftwidth=8 softtabstop=8 expandtab

" \t is 8 characters wide. Only use \t.
nnoremap <F9> :set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" \t is 8 characters wide. Indents are 4 characters wide. Mix tabs and spaces.
"
" Mix tabs and spaces so that tabs are 8 characters wide but indentation is
" 4 spaces wide. Thus, whitespace will consist of any number of tabs
" followed by four spaces if the start of the line is not aligned to an
" eight-charater boundary.
"nnoremap <F12> :set tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab

noremap <C-b> :call ToggleBackground() <CR>
noremap <C-c> :call ToggleColorcolumn() <CR>
noremap <C-o> :noh <CR>

" Switch to the previous tab
noremap <C-h> :tabp <CR>

" Switch to the next tab
noremap <C-l> :tabn <CR>

" Open a new tab
noremap <C-t> :tabe <CR>

let mapleader = "\\"

nnoremap <Leader>e :EasyBuffer <CR>
nnoremap <Leader>m :call InsertModeline() <CR>
nnoremap <Leader>v :call ThreeSplit() <CR>
nnoremap <Leader>w :call RemoveTrailingWhitespace() <CR>

" ------------------------------------------------------------------------------
" EVENT HANDLERS

autocmd FileType css,html,javascript,ruby,eruby :set tabstop=8 shiftwidth=2 softtabstop=2 expandtab
autocmd BufRead,BufNewFile *.handlebars :set filetype=html
autocmd BufRead,BufNewFile *.less :set filetype=css
autocmd FileType tex :set formatoptions+=t                  " Auto-wrap text for LaTeX files
autocmd BufRead,BufNewFile *.txt :set formatoptions+=t      " Auto-wrap text for plain text files

" ------------------------------------------------------------------------------
" LOCAL SETTINGS

if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif
