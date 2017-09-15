#!/usr/bin/env bash
#
# Perfoming install of full stack to run https://github.com/Artemmkin/reddit
# Make script a little bit idempotent as it runs each time on instance startup

if [ -d "/home/appuser/.rvm" ]; then
  echo "(Up-to-date) Ruby is already installed."
else
  curl -Ssl https://raw.githubusercontent.com/jugatsu/infra/48551d1c69e841011695608e2ce379c81a41f525/install_ruby.sh \
   | sudo -u appuser -i bash
fi

if [ -d "/var/lib/mongodb" ]; then
  echo "(Up-to-date) MongoDB is already installed."
else
  curl -Ssl https://raw.githubusercontent.com/jugatsu/infra/48551d1c69e841011695608e2ce379c81a41f525/install_mongodb.sh | bash
fi

if [ -d "/home/appuser/reddit" ]; then
  echo "(Up-to-date) Reddit app is already installed."
else
  curl -Ssl https://raw.githubusercontent.com/jugatsu/infra/48551d1c69e841011695608e2ce379c81a41f525/deploy.sh \
   | sudo -u appuser -i bash
fi
