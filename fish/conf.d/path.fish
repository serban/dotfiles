# Files in conf.d are sourced, in order, before config.fish is sourced.
# This file, path.fish, is sourced before virtualfish-loader.fish.
#
# When starting a new shell in a VirtualFish-connected directory, setting PATH
# after VirtaulFish auto-activation would break the virtual environment.
# Instead, we set PATH in this file to make it happen before VirtaulFish
# auto-activation.
set --global --export PATH \
    $HOME/bin \
    $HOME/src/private/bin \
    $HOME/src/dotfiles/bin \
    $HOME/src/dotfiles/python \
    $HOME/pre/bin \
    $HOME/go/bin \
    $HOME/.cargo/bin \
    $HOME/opt/google-cloud-sdk/bin \
    /usr/lib/google-golang/bin \
    /usr/local/git/current/bin \
    $HOME/homebrew/bin \
    $HOME/homebrew/sbin \
    $HOME/homebrew/opt/sqlite/bin \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    /opt/homebrew/opt/sqlite/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/lib/cargo/bin \
    /usr/bin \
    /usr/sbin \
    /bin \
    /sbin
