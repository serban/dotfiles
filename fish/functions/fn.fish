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
  set --local fdd   "fd --base-directory $root --type file --strip-cwd-prefix | sed 's/\.md\$//' | sort           | sed 's/\$/\.md/'"
  set --local fdr   "fd --base-directory $root --type file --strip-cwd-prefix | sed 's/\.md\$//' | sort --reverse | sed 's/\$/\.md/'"
  set --local fdt   "fd --base-directory $root --type file --strip-cwd-prefix | sed 's/\.md\$//' | sort --key 2   | sed 's/\$/\.md/'"
  set --local mvim  "mvim --remote-tab-silent +tabmove $root/{}"
  set --local open  "open -R $root/{}"
  set --local title "title 📝 {q}"

  set --local clip_base  'echo -n (builtin path basename {}) | fish_clipboard_copy'
  set --local clip_path  "echo -n '$root'/{} | fish_clipboard_copy"
  set --local osc52_base 'osc52 (builtin path basename {})'
  set --local osc52_path "osc52 '$root'/{}"

  set --local preview_window 'noinfo,right,80,hidden'
  if test "$COLUMNS" -ge 250
    set preview_window 'noinfo,right,140'
  else if test "$COLUMNS" -ge 190
    set preview_window 'noinfo,right,80'
  end

  title fn
  eval $fdt \
      | fzf --no-sort \
            --multi \
            --height 100% \
            --info inline-right \
            --input-border rounded \
            --list-border rounded \
            --list-label-pos -3 \
            --list-label ' Title ↓ ' \
            --preview-window $preview_window \
            --preview $bat \
            --bind 'resize:hide-preview' \
            --bind "alt-c:execute($osc52_base)" \
            --bind "alt-p:execute($osc52_path)" \
            --bind "alt-t:execute($title)" \
            --bind 'alt-h:change-preview-window(bottom,28|bottom,16)' \
            --bind 'alt-v:change-preview-window(right,140|right,80)' \
            --bind 'ctrl-g:change-preview-window(bottom,16|right,80)' \
            --bind "ctrl-o:execute-silent($open)" \
            --bind 'ctrl-q:toggle-preview' \
            --bind "ctrl-r:reload($fdr)+change-list-label( Date ↑ )" \
            --bind "ctrl-s:reload($fdd)+change-list-label( Date ↓ )" \
            --bind "ctrl-t:reload($fdt)+change-list-label( Title ↓ )" \
            --bind "ctrl-v:execute-silent($clip_path)" \
            --bind "ctrl-x:execute-silent($clip_base)" \
            --bind "double-click:execute-silent($mvim)" \
            --bind "enter:execute-silent($mvim)" \
            --bind 'esc:cancel'
#           --print0 \
#     | gsed --null-data "s|^|$root/|" \
#     | xargs -0 mvim --remote-tab-silent +tabmove
end
