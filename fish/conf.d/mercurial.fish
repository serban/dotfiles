abbr --add --global had hg add
abbr --add --global ham hg amend
abbr --add --global hco hg commit
abbr --add --global hdi hg diff
abbr --add --global hev hg evolve
abbr --add --global hlo hg log --stat
abbr --add --global hlp hg log --stat --patch --verbose --limit 1
abbr --add --global hme hg meld
abbr --add --global hrb hg rebase
abbr --add --global hrs hg resolve
abbr --add --global hst hg status
abbr --add --global hup hg update

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
