#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

print () {
  echo "==> $@"
}

print 'Creating parent directories'
mkdir -p "${HOME}/bin"
mkdir -p "${HOME}/src"

print 'Cloning clustergit repo'
git clone --quiet --recursive \
  https://github.com/mnagel/clustergit.git "${HOME}/src/clustergit"

print 'Copying clustergit executable into ~/bin'
cp -i "${HOME}/src/clustergit/clustergit" "${HOME}/bin/clustergit"
chmod 755 "${HOME}/bin/clustergit"
