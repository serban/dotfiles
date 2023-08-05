function cr --argument-names changelist author slug
  if test -z $changelist
    echo 'No changelist specified'
    return 1
  end

  if test -z $author
    echo 'No author specified'
    return 1
  end

  if test -z $slug
    echo 'No slug specified'
    return 1
  end

  set --function date (date '+%Y-%m-%d')
  set --function name "Code Review $changelist · $author · $slug"
  set --function head "# $date - $name"
  set --function file "$date $name.md"
  set --function path "$HOME/txt/code-review/$file"

  set --function client review-$changelist-$slug

  if test -e $path
    echo "Note exists: $path"
    return 1
  end

  echo $head >> $path
  echo >> $path
  echo '```fish' >> $path
  echo "mag review-$changelist-$slug" (cat ~/src/dotfiles-google/google3-folders | fzf) >> $path
  echo '```' >> $path
  echo >> $path

  ssh monk "fish -c 'hgd -f $client && hg patch $changelist'"
  ssh monk "fish -c 'hgd $client && hrt'" | grep --extended-regexp '^(│|├)' >> $path

  mvim --remote-tab-silent $path
end
