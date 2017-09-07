#!/usr/bin/env bash
#
# Perfoming deploy of reddit app (https://github.com/Artemmkin/reddit.git)

set -o errexit

git clone https://github.com/Artemmkin/reddit.git
cd reddit && bundle install
puma -d
