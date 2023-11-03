function bd
  set --local options (fish_opt --short=m --long=missing)

  if not argparse $options -- $argv
    return
  end

  set --local packages (cat ~/src/dotfiles/packages/homebrew-{core,dev,fun,media,py-libs,py-repls,py-tools}.txt)
  set --local output_dir (gmktemp --directory --tmpdir 'bd.XXXXXX')

  set --local expected          '1-expected.txt'
  set --local expected_sorted   '2-expected-sorted.txt'
  set --local leaves_sorted     '3-leaves-sorted.txt'
  set --local installed_sorted  '4-installed-sorted.txt'
  set --local removable         '5-removable.txt'
  set --local leaves_added      '6-leaves-added.txt'
  set --local packages_added    '7-packages-added.txt'
  set --local packages_missing  '8-packages-missing.txt'

  pushd $output_dir

  for package in $packages
    echo $package >> $expected
  end
  brew deps --union --full-name $packages >> $expected
  sort --unique $expected > $expected_sorted

  brew leaves | sort --unique > $leaves_sorted
  brew list --formula --full-name | sort --unique > $installed_sorted
  brew autoremove --dry-run > $removable

  comm -13 $expected_sorted $leaves_sorted > $leaves_added
  comm -13 $expected_sorted $installed_sorted > $packages_added
  comm -23 $expected_sorted $installed_sorted > $packages_missing

  header 'Leaves Added'
  cat $leaves_added

  header 'Packages Added'
  cat $packages_added

  if test -n "$_flag_missing"
    header 'Packages Missing'
    cat $packages_missing
  end

  header 'Packages Removable'
  cat $removable

  header 'Cheatsheet'
  echo '• brew deps --tree --include-build formula'
  echo '• brew uses --installed --recursive --include-build formula'
  echo '• brew autoremove --dry-run'
  echo '• brew cleanup -s --dry-run'

  popd
  rm -r $output_dir
end
