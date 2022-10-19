function vic
  read --function response --nchars 1 --prompt-str \
      (set_color brmagenta)"■ Vim or NeoVim? "(set_color yellow)
  switch $response
    case v
      commandline vim
      commandline --function execute
    case n
      commandline nvim
      commandline --function execute
  end
end
