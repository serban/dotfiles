function wg
  title wg
  set --function dir \
      (fd --base-directory ~/wks --type directory --max-depth 1 --strip-cwd-prefix \
           | sed 's|/$||' \
           | sort \
           | fzf --no-sort \
                 --height 100% \
                 --prompt '⁖ ~/wks/' \
                 --bind enter:accept-non-empty \
                 --bind esc:cancel)

  test -n "$dir" && g ~/wks/$dir
end
