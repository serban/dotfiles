abbr --add had hg add
abbr --add ham hg amend
abbr --add hco hg commit
abbr --add hdc hg diff --change
abbr --add hdf hg diff --from
abbr --add hdi hg diff
abbr --add hev hg evolve
abbr --add hlo hg log --stat
abbr --add hlp hg log --stat --patch --verbose --limit 1
abbr --add hme hg meld
abbr --add hrb hg rebase
abbr --add hrs hg resolve
abbr --add hst hg status
abbr --add hup hg update

abbr --add hec 'e (hg status --no-status --change .)'
abbr --add heb 'e (hg status --no-status --rev p4base)'

# Fig Aliases
abbr --add hau 'hg amend && hg uploadchain && hg xl'
abbr --add hae 'hg amend && hg evolve && hg uploadchain && hg xl'
abbr --add huc 'hg uploadchain && hg xl'
abbr --add hsy 'hg sync && hg xl'
abbr --add hsu 'hg sync && hg uploadchain && hg xl'
abbr --add hxl 'hg xl && hg status'

# dandavison/delta wrappers

abbr --add hdps 'hg diff --change . | delta --features (dark)-side-by-side'
abbr --add hdpu 'hg diff --change . | delta --features (dark)-unified-diff'

function hdis
  hg diff $argv | delta --features (dark)-side-by-side
end

function hdiu
  hg diff $argv | delta --features (dark)-unified-diff
end

# Fig

function hre --argument-names changelist slug
  if test -z $changelist
    echo 'No changelist specified'
    return 1
  end

  if test -z $slug
    echo 'No slug specified'
    return 1
  end

  set --function client review-$changelist-$slug

  hgd -f $client
  hg patch $changelist
  hg reword --message "Review of cl/$changelist"

  mag $client
end

function hrf
  hg status --no-status --change . \
    | grep --invert-match 'BUILD$' \
    | sort \
    | sed 's/^/· /'
end

function hrt
  set --function width_outer 110
  set --function width_inner (math $width_outer - 2)

  printf '│ ✓ │ %-'$width_inner's │ ‹ Notes │\n' '‹ File'
  printf '├───┼%s┼─────────┤\n' (string repeat --no-newline --count $width_outer ─)

  for f in (hg status --no-status --change . | grep --invert-match 'BUILD$' | sort)
    printf '│ · │ %-'$width_inner's │         │\n' $f
  end
end
