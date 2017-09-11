#!/usr/bin/env bash
#
# Perfoming install of MongoDB (https://www.mongodb.com/)

set -o errexit

tee -a /etc/apt/sources.list.d/mongodb-org-3.2.list << EOF
deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse
EOF
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv EA312927
apt-get update
apt-get -y install mongodb-org
systemctl start mongod
systemctl enable mongod
