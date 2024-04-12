#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

mkdir -vp ~/bin ~/env ~/frk ~/git ~/log ~/oss ~/pkg ~/pre ~/run ~/ses ~/src ~/txt ~/uvd ~/wks

if [[ "$(uname -s)" == Darwin ]]; then
  mkdir -vp ~/Data ~/Deletable ~/Screenshots ~/Workspace
fi
