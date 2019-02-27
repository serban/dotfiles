function b --argument-names bookmark
  if test -z "$bookmark"
    bookmarks list
  else
    g (bookmarks get $bookmark)
  end
end
