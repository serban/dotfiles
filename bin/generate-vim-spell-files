#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${1:-''}" == '--wait' ]]; then
  vim +'call SerbanGenerateSpellFiles()'
else
  vim +'call SerbanGenerateSpellFiles()' +quitall
fi
