function ag --wraps ag
  set --local  options (fish_opt --short=c --long=cpp)
  set options $options (fish_opt --short=d --long=directory --multiple-vals)
  set options $options (fish_opt --short=f --long=files)
  set options $options (fish_opt --short=g --long=go)
  set options $options (fish_opt --short=h --long=html)
  set options $options (fish_opt --short=j --long=java)
  set options $options (fish_opt --short=k --long=kotlin)
  set options $options (fish_opt --short=i --long=literal)
  set options $options (fish_opt --short=l --long=list-file-types)
  set options $options (fish_opt --short=p --long=python)
  set options $options (fish_opt --short=r --long=rust)
  set options $options (fish_opt --short=s --long=shell)
  set options $options (fish_opt --short=t --long=ignore-tests)
  set options $options (fish_opt --short=u --long=unrestricted)
  set options $options (fish_opt --short=v --long=variants)

  if not argparse $options -- $argv
    return
  end

  # Documentation for the --context flag is confusing. See:
  # • https://github.com/ggreer/the_silver_searcher/issues/74
  # • https://github.com/ggreer/the_silver_searcher/issues/404
  # • https://github.com/ggreer/the_silver_searcher/issues/716
  set --local args \
      --group \
      --color \
      --color-path 95 \
      --color-line-number 34 \
      --color-match 31 \
      --context=2 \
      #

  if test -n "$_flag_cpp"
    set args $args --cc --cpp
  end

  if test -n "$_flag_directory"
    header Directories
    set_color green
    for dir in $_flag_directory
      echo • $dir
    end
    set_color normal
    header Results
  end

  if test -n "$_flag_files"
    set args $args --files-with-matches
  end

  if test -n "$_flag_go"
    set args $args --go
  end

  if test -n "$_flag_html"
    set args $args --html
  end

  if test -n "$_flag_java"
    set args $args --java
  end

  if test -n "$_flag_kotlin"
    set args $args --kotlin
  end

  if test -n "$_flag_literal"
    set args $args --literal
  end

  if test -n "$_flag_list_file_types"
    set args $args --list-file-types
  end

  if test -n "$_flag_python"
    set args $args --python
  end

  if test -n "$_flag_rust"
    set args $args --rust
  end

  if test -n "$_flag_shell"
    set args $args --shell
  end

  if test -n "$_flag_ignore_tests"
    set args $args --ignore '*_test.*'
  end

  if test -n "$_flag_unrestricted"
    set args $args --unrestricted
  end

  if test -n "$_flag_variants"
    if test -z $argv[1]
      echo 'No pattern specified'
      return 1
    end

    set --local tokens \
        (string split _ \
            (string replace --all ' ' _ \
                (string replace --all - _ \
                    (string lower $argv[1]))))

    set argv[1] (string join '|' \
        (string join '' $tokens) \
        (string join '-' $tokens) \
        (string join '_' $tokens) \
        (string join '\s+' $tokens)) \
        #

    printf '%s⁖ %s ⁙%s\n\n' (set_color magenta) $argv[1] (set_color normal)
  end

  # https://github.com/ggreer/the_silver_searcher/issues/714
  # ↳ Visual alignment of results, and differently-lengthed line-numbers
  command ag $args $argv $_flag_directory \
    | perl -pe 's/(?<=^\e\[34m)(\d+)\e\[0m\e\[K(:|-)/sprintf("%4d\e\[0m ", $1)/e' \
    | less
end
