function fe --argument-names extension
  if test -z "$extension"
    echo 'You must specify a file extension'
    return 1
  end

  find . -iname "*.$extension"
end
