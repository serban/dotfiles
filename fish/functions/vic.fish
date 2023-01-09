function vic
  while true
    read --local response --nchars 1 --prompt-str \
        (set_color brmagenta)'■ Vim or NeoVim? '(set_color yellow)
    switch $response
      case v
        commandline vim
        commandline --function execute
        break
      case n
        commandline nvim
        commandline --function execute
        break
      case q
        break
    end
  end
end
