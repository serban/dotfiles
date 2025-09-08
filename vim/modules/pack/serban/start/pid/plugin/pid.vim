if exists('g:loaded_pid')
  finish
endif
let g:loaded_pid = v:true

if !exists('g:pid_root')
  let g:pid_root = '~/run/vim'
endif

augroup pid
  autocmd!
  autocmd VimLeave * call pid#DeletePidFile()
augroup end

call pid#WritePidFile()
