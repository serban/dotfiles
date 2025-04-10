#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# https://unix.stackexchange.com/questions/209123/understanding-ifs-read-r-line
# https://unix.stackexchange.com/questions/275794/iterating-over-multiple-line-string-stored-in-variable
print () {
  while IFS= read -r line; do
    echo "pip: $line" 1>&2
  done <<< "$@"
}

PIP3_PATH="$(which pip3)" || true
PYTHON_PATH="$(which python)" || true
PYTHON3_PATH="$(which python3)" || true
PYTHON3_SITE_INFO="$(python3 -m site)" || true
VIRTUALFISH_PYTHON_EXEC="$(grep -oE 'VIRTUALFISH_PYTHON_EXEC.+' ~/.config/fish/conf.d/virtualfish-loader.fish | cut -d ' ' -f 2)" || true

print '╭──────────────────────────────────────────────────────────────────────╮'
print '│ Environment                                                          │'
print '╰──────────────────────────────────────────────────────────────────────╯'
print

if [[ -z "${PYTHON_PATH}" ]]; then
  print " python is not in your path"
else
  print " python is ${PYTHON_PATH} → $(readlink ${PYTHON_PATH})"
fi

if [[ -z "${PIP3_PATH}" ]]; then
  print "   pip3 is not in your path"
else
  print "   pip3 is ${PIP3_PATH} → $(readlink ${PIP3_PATH})"
fi

if [[ -z "${PYTHON3_PATH}" ]]; then
  print "python3 is not in your path"
else
  print "python3 is ${PYTHON3_PATH} → $(readlink ${PYTHON3_PATH})"
fi

if [[ -z "${PYTHON3_SITE_INFO}" ]]; then
  print "python3 site info missing"
else
  print "${PYTHON3_SITE_INFO}"
fi

if [[ -z "${VIRTUALFISH_PYTHON_EXEC}" ]]; then
  print "VirtualFish is not installed"
else
  print "VIRTUALFISH_PYTHON_EXEC: ${VIRTUALFISH_PYTHON_EXEC}"
fi

print
print '╭──────────────────────────────────────────────────────────────────────╮'
print '│ Usage                                                                │'
print '╰──────────────────────────────────────────────────────────────────────╯'
print
print 'You are outside of a virtualenv. Use pip3 explicitly:'
print
print 'List packages:              $ pip3 list'
print 'List user packages:         $ pip3 list --user'
print 'Install a package (macOS):  $ PIP_REQUIRE_VIRTUALENV=false pip3 install package'
print 'Install a package (Debian): $ PIP_REQUIRE_VIRTUALENV=false pip3 install --user package'
print 'Upgrade pip itself (macOS): $ PIP_REQUIRE_VIRTUALENV=false pip3 install --upgrade pip'

# In case this gets called from a script somewhere, make sure that script fails.
exit 1
