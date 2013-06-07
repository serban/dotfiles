set columns=114
set lines=52

if filereadable(expand("~/.gvimrc_local"))
    source ~/.gvimrc_local
endif
