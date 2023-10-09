function ws
  set --function date (date +%Y-%m-%d)
  set --function fold wks
  set --function open

  if test (uname -s) = Darwin
    set fold Workspace
    set open true
  end

  set --function path ~/$fold/$date

  mkdir -p $path
  cd $path

  if test -n "$open"
    n
  end
end
