function fn
  set --local theme (bat_theme)
  fd --base-directory ~/txt --strip-cwd-prefix --type file \
      | fzf --multi \
            --height 100% \
            --preview-window right,60% \
            --preview "bat --color always --theme '$theme' --plain ~/txt/{}" \
            --print0 \
      | gsed --null-data 's|^|~/txt/|' \
      | xargs -0 mvim --remote-tab-silent
end
