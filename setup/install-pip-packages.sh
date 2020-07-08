#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PIP_REQUIRE_VIRTUALENV=false pip3 install \
  bpython \
  virtualfish \
  wavemaker

vf install auto_activation update_python
