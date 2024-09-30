function fn
  title fn

  set --local theme (bat_theme)
  set --local root  '~/txt'
  set --local bat   "bat --color always --theme '$theme' --plain $root/{}"
  set --local fd    "fd --base-directory $root --type file --strip-cwd-prefix | sort"
  set --local mvim  "mvim --remote-tab-silent $root/{}"
  set --local open  "open -R $root/{}"

  eval $fd \
      | fzf --no-sort \
            --multi \
            --height 100% \
            --preview-window right,60% \
            --preview $bat \
            --bind 'ctrl-g:change-preview-window(right,80|bottom,60%|hidden|)' \
            --bind "ctrl-o:execute-silent($open)" \
            --bind "ctrl-r:reload($fd)" \
            --bind "ctrl-s:reload($fd -k 2)" \
            --bind "double-click:execute-silent($mvim)" \
            --bind "enter:execute-silent($mvim)" \
            --bind 'esc:cancel'
#           --print0 \
#     | gsed --null-data "s|^|$root/|" \
#     | xargs -0 mvim --remote-tab-silent
end
