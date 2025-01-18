function vic
  while true
    read --local response --nchars 1 --prompt-str \
        (set_color brmagenta)'■ Vim or NeoVim? '(set_color yellow)
    switch $response
      case v
        append_history_and_run vim
        break
      case n
        append_history_and_run nvim
        break
      case q
        break
    end
  end
end
