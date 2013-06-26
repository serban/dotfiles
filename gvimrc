set columns=90
set lines=60

if filereadable(expand("~/.gvimrc_local"))
    source ~/.gvimrc_local
endif
