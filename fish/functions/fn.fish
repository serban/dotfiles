function fn
  set --local theme (bat_theme)
  title fn
  fd --base-directory ~/txt --type file --strip-cwd-prefix | sort \
      | fzf --no-sort \
            --multi \
            --height 100% \
            --preview-window right,60% \
            --preview "bat --color always --theme '$theme' --plain ~/txt/{}" \
            --bind 'ctrl-g:change-preview-window(right,80|bottom,60%|hidden|)' \
            --bind 'ctrl-o:execute-silent(open -R ~/txt/{})' \
            --bind 'ctrl-r:reload(fd --base-directory ~/txt --type file --strip-cwd-prefix | sort)' \
            --bind 'double-click:execute-silent(mvim --remote-tab-silent ~/txt/{})' \
            --bind 'enter:execute-silent(mvim --remote-tab-silent ~/txt/{})' \
            --bind 'esc:cancel'
#           --print0 \
#     | gsed --null-data 's|^|~/txt/|' \
#     | xargs -0 mvim --remote-tab-silent
end
