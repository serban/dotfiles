#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

list() {
  find "$1" -type f
}

list /Library/LaunchAgents
list /Library/LaunchDaemons
list /Library/StartupItems
list /System/Library/LaunchAgents
list /System/Library/LaunchDaemons
list /System/Library/StartupItems
list ~/Library/LaunchAgents
