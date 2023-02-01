abbr --add --global had hg add
abbr --add --global ham hg amend
abbr --add --global hco hg commit
abbr --add --global hdc hg diff --change
abbr --add --global hdf hg diff --from
abbr --add --global hdi hg diff
abbr --add --global hev hg evolve
abbr --add --global hlo hg log --stat
abbr --add --global hlp hg log --stat --patch --verbose --limit 1
abbr --add --global hme hg meld
abbr --add --global hrb hg rebase
abbr --add --global hrs hg resolve
abbr --add --global hst hg status
abbr --add --global hup hg update

abbr --add --global hec 'e (hg status --no-status --change .)'
abbr --add --global heb 'e (hg status --no-status --rev p4base)'

# Fig Aliases
abbr --add --global hau 'hg amend && hg uploadchain && hg xl'
abbr --add --global hae 'hg amend && hg evolve && hg uploadchain && hg xl'
abbr --add --global huc 'hg uploadchain && hg xl'
abbr --add --global hsy 'hg sync && hg xl'
abbr --add --global hsu 'hg sync && hg uploadchain && hg xl'
abbr --add --global hxl 'hg xl && hg status'

# dandavison/delta wrappers

abbr --add --global hdps 'hg diff --change . | delta --features (dark)-side-by-side'
abbr --add --global hdpu 'hg diff --change . | delta --features (dark)-unified-diff'

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

  printf '| ✓ | %-'$width_inner's | Notes |\n' File
  printf '|---|%s|-------|\n' (string repeat --no-newline --count $width_outer -)

  for f in (hg status --no-status --change . | grep --invert-match 'BUILD$' | sort)
    printf '| · | %-'$width_inner's |       |\n' $f
  end
end
