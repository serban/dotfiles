function serban_fish_version_ge --argument-names min
  if test -z "$min"
    echo 'You must specify a minimum version'
    return 1
  end

  printf '%s\n%s\n' $min $FISH_VERSION | sort --version-sort --check=silent
end
