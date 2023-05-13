" Compare two buffers to determine their ordering.
" d1 and d2 are dictionaries as returned by getbufinfo().
"
" The three possible return values are:
"  0 if d1 is equal to  d2
" -1 if d1 comes before d2
" +1 if d1 comes after  d2
function bufselect#CompareBuffers(d1, d2)
  " The full paths of the files.
  let p1 = a:d1.name
  let p2 = a:d2.name

  " The roots of the paths: everything except the final period and extension.
  let r1 = fnamemodify(p1, ':r')
  let r2 = fnamemodify(p2, ':r')

  " Sort header files before implementation files.
  if r1 ==# r2
    " Just the final extensions of the file names, excluding the period.
    let e1 = fnamemodify(p1, ':e')
    let e2 = fnamemodify(p2, ':e')

    let before = ['h']
    let after  = ['c', 'cc', 'cpp', 'cu']

    " if e1 in before and e2 in after
    if index(before, e1) >= 0 && index(after, e2) >= 0
      return -1
    endif

    " if e2 in before and e1 in after
    if index(before, e2) >= 0 && index(after, e1) >= 0
      return 1
    endif
  endif

  return p1 ==# p2 ? 0 : (p1 <# p2 ? -1 : 1)
endfunction

function bufselect#BufferDisplayName(number, path, changed)
  let s = a:changed ? '+ ' : '  '

  if a:path ==# ''
    return s . '[No Name] (' . a:number . ')'
  endif

  " fnamemodify() manipulates the full path into a shorter version if it is
  " located in the home directory.
  let path = fnamemodify(a:path, ':~')

  " Strip the leading srcfs path from CitC files.
  let path = substitute(path,
             \          '\v^/google/src/cloud/[^/]+/[^/]+/google3/', '', '')

  return s . path
endfunction

" Return all the buffers in a tuple of three items.
"
" The 1st item is a list of buffer numbers.
" The 2nd item is a list of buffer paths.
" The 3rd item is a list of buffer display names.
"
" The items at each position in each sublist correspond to each other.
function bufselect#Buffers()
  " getbufinfo() returns a list of dictionaries, one for each buffer. We only
  " care about two items in the dictionary, 'bufnr' and 'name', which contain
  " the buffer number and full path to the file, respectively.
  let buffers = getbufinfo({'buflisted': 1})
  call sort(buffers, 'bufselect#CompareBuffers')

  let numbers = []
  let paths = []
  let names = []

  for i in range(len(buffers))
    let number  = buffers[i].bufnr
    let path    = buffers[i].name
    let changed = buffers[i].changed

    call add(numbers, number)
    call add(paths, path)
    call add(names, bufselect#BufferDisplayName(number, path, changed))
  endfor

  return [numbers, paths, names]
endfunction

function bufselect#MenuCallback(_, index)
  " NB: The first menu item starts at index 1.
  if a:index > 0
    execute 'silent' 'buffer' bufselect#Buffers()[0][a:index-1]
  endif
endfunction

function bufselect#OpenMenu()
  let buffers = bufselect#Buffers()
  let numbers = buffers[0]
  let names = buffers[2]

  let opts = {
  \   'callback': 'bufselect#MenuCallback',
  \   'title': ' Buffers ',
  \   'padding': [1, 3, 1, 3],
  \   'maxheight': &lines - 7,
  \   'highlight': 'BufSelectHighlight',
  \   'borderhighlight': ['BufSelectBorderHighlight'],
  \}

  let window_id = popup_menu(names, opts)

  " Check if bufselect is being invoked from an unlisted buffer.
  let idx = index(numbers, bufnr())
  if idx <# 0
    return
  endif

  " Move the selection down to the current buffer.
  " The following does not work because zero is not a valid count:
  "   call win_execute(id, 'normal! ' . index(numbers, bufnr()) . 'j')
  for i in range(idx)
    call win_execute(window_id, 'normal! j')
  endfor
endfunction
