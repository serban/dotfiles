#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly -a kFoldersCommon=(

  bin
  del
  env
  frk
  git
  log
  oss
  pre
  run
  ses
  src
  txt
  uvd
  wks

)

readonly -a kFoldersDarwin=(

  Data
  Screenshots

)

declare -A kSymlinksDarwin=(

# [Data]='Library/Mobile Documents/com~apple~CloudDocs/Data'
  [Deletable]=del
  [Workspace]=wks

)

function makedir {
  mkdir -vpm 700 "${1}"
  chmod -v   700 "${1}"
}

cd
umask u=rwx,g=,o=  # umask 077

for folder in "${kFoldersCommon[@]}"; do
  makedir "${folder}"
done

if [[ "$(uname -s)" == Darwin ]]; then
  for folder in "${kFoldersDarwin[@]}"; do
    makedir "${folder}"
  done

  for link in "${!kSymlinksDarwin[@]}"; do
#   echo "${link}" → "${kSymlinksDarwin[${link}]}"
    ln -vsnf "${kSymlinksDarwin[${link}]}" "${link}"
  done
fi
