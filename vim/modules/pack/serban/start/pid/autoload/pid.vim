function pid#VimVariant()
  if has('gui_macvim') && has('gui_running')
    return 'MacVim'
  elseif exists('g:neovide')
    return 'Neovide'
  elseif has('nvim')
    return 'Neovim'
  else
    return 'Vim'
  endif
endfunction

function pid#VimVersion()
  if exists('g:neovide')
    return g:neovide_version
  endif
  return has('nvim') ? luaeval('tostring(vim.version())') : v:versionlong
endfunction

function pid#PidFilePath()
  return g:pid_root . '/' . getpid() . '.json'
endfunction

function pid#WritePidFile()
  let data = {
  \   'pid'             : getpid(),
  \   'start_time_sec'  : localtime(),
  \   'variant'         : pid#VimVariant(),
  \   'version'         : pid#VimVersion(),
  \   'cwd'             : fnamemodify(getcwd(), ':~'),
  \   'term'            : $TERM,
  \   'term_program'    : $TERM_PROGRAM,
  \   'tmux_pane'       : $TMUX_PANE,
  \}
  call mkdir(expand(g:pid_root), 'p')
  call writefile([json_encode(data)], expand(pid#PidFilePath()))
endfunction

function pid#DeletePidFile()
  call delete(expand(pid#PidFilePath()))
endfunction
