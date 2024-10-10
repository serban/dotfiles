# fish_clipboard_copy() already does this on top of calling pbcopy et al
# ↳ https://github.com/fish-shell/fish-shell/blob/5db0bd5874e76eb37f8efc22230479e6639681f7/share/functions/fish_clipboard_copy.fish#L28
function osc52
  set --function payload (echo -n $argv[1] | base64)
  test -n "$payload" && echo -n \033]52\;c\;$payload\007
end
