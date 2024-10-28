# U+1F440  👀  Eyes
# U+1F50D  🔍  Left-Pointing Magnifying Glass

function fl
  if test (count $argv) -ne 1
    return 1
  end

  title 👀 $argv[1]

  set --local theme (bat_theme)
  set --local argv1 (string escape $argv[1])

  set --local bat   "bat --color always --theme '$theme' --number --highlight-line {1} $argv1"
  set --local cat   "cat $argv1 | gnl --body-numbering all --number-width 4 --number-separator ' '"
  set --local mvim  "mvim --remote-tab-silent +{1} $argv1"

  eval $cat \
      | fzf --no-sort \
            --track \
            --nth 2.. \
            --height 100% \
            --info inline-right \
            --preview-window 'bottom,40%,noinfo,+{1}/3' \
            --preview $bat \
            --bind 'ctrl-g:toggle-preview' \
            --bind "ctrl-r:reload($cat)" \
            --bind 'ctrl-s:first' \
            --bind "double-click:execute-silent($mvim)" \
            --bind "enter:execute-silent($mvim)" \
            --bind 'esc:cancel'
end
