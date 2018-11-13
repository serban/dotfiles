set columns=90
set lines=60

colorscheme solarized

if filereadable(expand("~/.gvimrc_local"))
  source ~/.gvimrc_local
endif
