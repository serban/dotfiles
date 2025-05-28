#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ -f /etc/debian_version ]]; then
  readonly PYTHON=/usr/bin/python3  # Python 3.11 on Debian 12 Bookworm
else
  readonly PYTHON="${HOME}/env/pyenv/versions/3.14.0b2/bin/python3"
fi

exec -a python3 "${PYTHON}" "$@"
