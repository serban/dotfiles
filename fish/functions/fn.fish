function fn
  fd --base-directory ~/txt --type file \
      | fzf --multi \
            --height 100% \
            --preview-window right,60% \
            --preview 'bat --color always --plain ~/txt/{}' \
            --print0 \
      | gsed --null-data 's|^|~/txt/|' \
      | xargs -0 mvim --remote-tab-silent
end
