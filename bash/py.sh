#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -f /etc/debian_version ]]; then
  readonly PYTHON=/usr/bin/python3.11
else
  readonly PYTHON="${HOME}/env/pyenv/versions/3.13.0rc3/bin/python3"
fi

exec -a python3 "${PYTHON}" "$@"
