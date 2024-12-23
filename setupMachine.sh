#!/bin/bash

main() {
  ensure_brew_installed
  install_brew_packages
  setup_dotfiles
  install_asdf
  install_global_node_modules
  install_cask_packages
}

ensure_brew_installed() {
  if ! [ -x $(which brew) ]
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

install_brew_packages() {
  brew_install bash
  brew_install bash-completion@2
  brew_install bash-git-prompt
  brew_install bat
  brew_install coreutils
  brew_install fop
  brew_install gh
  brew_install git
  brew_install git-delta
  brew_install gpg  # Needed for asdf nodejs plugin
  brew_install jq
  brew_install rlwrap
  brew_install unixodbc
  brew_install wxwidgets
}

setup_dotfiles() {
  brew tap thoughtbot/formulae
  brew_install rcm
  if ! [ -e $HOME/.dotfiles ]
  then
    ( cd $HOME; git clone git@github.com:randycoulman/dotfiles.git .dotfiles )
  fi
  ( cd $HOME/.dotfiles; rcup rcrc; rcup )
}

install_asdf() {
  ensure_asdf_installed
  install_asdf_plugins
  install_asdf_languages
}

install_global_node_modules() {
  npm_install yarn
  npm_install git-mob
}

install_cask_packages() {
  brew tap homebrew/cask-fonts
  brew_install font-inconsolata
  brew_install font-source-code-pro
  brew_install libreoffice
  brew_install quicklook-json
  brew_install sweet-home3d
  brew_install thunderbird
}

ensure_asdf_installed() {
  brew_install asdf
  source /usr/local/opt/asdf/asdf.sh
}

install_asdf_plugins() {
  install_asdf_plugin elixir
  install_asdf_plugin erlang
  install_asdf_plugin nodejs
}

install_asdf_languages() {
  asdf_install elixir 1.16.0-otp-26
  asdf_install erlang 26.2.1
  if ! asdf list nodejs > /dev/null
  then
    bash /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf_install nodejs 18.12.1
  fi
}

install_asdf_plugin() {
  plugin=$1
  if ! asdf plugin-list | grep $plugin
  then
    asdf plugin-add $plugin https://github.com/asdf-vm/asdf-$plugin.git
  else
    asdf plugin-update $plugin
  fi
}

brew_install() {
  package=$1
  if ! brew ls $package > /dev/null
  then
    brew install $package
  fi
}

asdf_install() {
  language=$1
  version=$2
  asdf install $language $version
  asdf global $language $version
}

npm_install() {
  module=$1
  if ! npm ls -g $module > /dev/null
  then
    npm install -g $module
  fi
}

gem_install() {
  gem=$1
  if ! gem list -i $gem > /dev/null
  then
    gem install $gem
  fi
}

main
