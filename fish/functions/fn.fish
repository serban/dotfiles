# ╭────────────────────────────────────────────────────────────────────────────╮
# │ Tips                                                                       │
# ╰────────────────────────────────────────────────────────────────────────────╯
# • fzf: Commands are executed with `$SHELL -c`, aka fish.
# • fzf: The {} placeholder is already single-quoted by fzf.
# • fzf: OSC 52 works with fzf execute() but not execute-silent().
# • fish: Use fish command substitution `()` to remove a trailing newline.
#   ↳ https://github.com/fish-shell/fish-shell/issues/3847#issuecomment-1321871256

function fn
  set --local theme (dark)

  set --local root  '~/txt'
  set --local bat   "bat --color always --theme '$theme' --plain $root/{}"
  set --local fd    "fd --base-directory $root --type file --strip-cwd-prefix | sort"
  set --local mvim  "mvim --remote-tab-silent $root/{}"
  set --local open  "open -R $root/{}"
  set --local title "title 📝 {q}"

  set --local clip_base  'echo -n (builtin path basename {}) | fish_clipboard_copy'
  set --local clip_path  "echo -n '$root'/{} | fish_clipboard_copy"
  set --local osc52_base 'osc52 (builtin path basename {})'
  set --local osc52_path "osc52 '$root'/{}"

  title fn
  eval $fd \
      | fzf --no-sort \
            --multi \
            --height 100% \
            --info inline-right \
            --preview-window right,80,noinfo \
            --preview $bat \
            --bind "alt-c:execute($osc52_base)" \
            --bind "alt-p:execute($osc52_path)" \
            --bind "alt-t:execute($title)" \
            --bind 'alt-h:change-preview-window(bottom,28|bottom,16)' \
            --bind 'alt-v:change-preview-window(right,140|)' \
            --bind 'ctrl-g:change-preview-window(bottom,16|)' \
            --bind "ctrl-o:execute-silent($open)" \
            --bind 'ctrl-q:toggle-preview' \
            --bind "ctrl-r:reload($fd)" \
            --bind "ctrl-s:reload($fd --key 2)" \
            --bind "ctrl-t:reload($fd --reverse)" \
            --bind "ctrl-v:execute-silent($clip_path)" \
            --bind "ctrl-x:execute-silent($clip_base)" \
            --bind "double-click:execute-silent($mvim)" \
            --bind "enter:execute-silent($mvim)" \
            --bind 'esc:cancel'
#           --print0 \
#     | gsed --null-data "s|^|$root/|" \
#     | xargs -0 mvim --remote-tab-silent
end
