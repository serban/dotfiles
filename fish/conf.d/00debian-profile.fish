# This file exists to prevent
# /usr/share/fish/vendor_conf.d/00debian-profile.fish from breaking my $PATH.
#
# Without this override, the PATH which I set in ~/.config/fish/conf.d/path.fish
# is reset by /usr/share/fish/vendor_conf.d/00debian-profile.fish after fish
# sources everything in ~/.config/fish/conf.d. See:
#
# • https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1001584
#   » fish: login shell resets $PATH between user's conf.d/ config and user's config.fish
# • https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1000199
#   » $PATH is reset because of Debian patch
# • https://github.com/fish-shell/fish-shell/issues/8553
#   » conf.d sourcing order is awkward
