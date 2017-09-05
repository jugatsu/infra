#!/usr/bin/env bash
#
# Perfoming install of ruby via RVM (https://rvm.io)

function app_add_public_key() {
  # add mpapis public key
  echo -e "Adding mpapis public key...\\n"
  gpg --keyserver hkp://keys.gnupg.net \
  --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB > /dev/null 2>&1
  gpg_exit_code=$?
  if [[ "$gpg_exit_code" -ne 0 ]]; then
    echo "Install of mpapis public key failed with ERROR: $gpg_exit_code"
    exit 1
  fi
}

function app_install_rvm() {
  # install RVM via curl
  echo -e "Installing RVM...\\n"
  curl -sSL https://get.rvm.io | bash -s stable > /dev/null 2>&1
  return_codes=(${PIPESTATUS[*]})
  if [[ "${return_codes[0]}" -ne 0 ]]; then
    echo "curl failed with ERROR: ${return_codes[0]}"
    exit 1
  fi
  if [[ "${return_codes[1]}" -ne 0 ]]; then
    echo "rvm install script failed with ERROR: ${return_codes[1]}"
    exit 1
  fi
}

function app_install_ruby() {
  ruby_version=2.4.1
  # source RVM script
  echo -e "Reloading shell...\\n"
  # shellcheck source=/dev/null
  source "$HOME/.rvm/scripts/rvm"
  # install ruby
  echo -e "Installing ruby ${ruby_version}...\\n"
  rvm install $ruby_version > /dev/null 2>&1
  rvm_exit_code=$?
  if [[ "${rvm_exit_code}" -ne 0 ]]; then
    echo "Install of ruby failed with ERROR: $rvm_exit_code"
    exit 1
  fi

  echo -e "Setting default ruby to $ruby_version...\\n"
  rvm use $ruby_version --default > /dev/null 2>&1
}

function app_install_bundler() {
  # install bundler
  echo -e "Installing bundler...\\n"
  gem install bundler -V --no-ri --no-rdoc > /dev/null 2>&1
  gem_exit_code=$?
  if [[ "${gem_exit_code}" -ne 0 ]]; then
    echo "Install of bundler failed with ERROR: $gem_exit_code"
    exit 1
  fi
}

app_add_public_key
app_install_rvm
app_install_ruby
app_install_bundler
