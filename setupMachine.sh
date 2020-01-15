#!/bin/bash

main() {
  ensure_brew_installed
  install_brew_packages
  setup_dotfiles
  install_asdf
  install_global_gems
  install_global_node_modules
  install_cask_packages
}

ensure_brew_installed() {
  if ! [ -x $(which brew) ]
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

install_brew_packages() {
  brew_install bash
  brew_install bash-completion@2
  brew_install bash-git-prompt
  brew_install coreutils
  brew_install git
  brew_install gpg  # Needed for asdf nodejs plugin
  cask_install java
  brew_install plantuml
  brew_install sqlite
}

install_asdf() {
  ensure_asdf_installed
  install_asdf_plugins
  install_asdf_languages
}

install_global_gems() {
  gem_install bundler
  gem_install git_snip
  gem_install pair-up
}

install_global_node_modules() {
  npm_install -g yarn
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

install_cask_packages() {
  brew tap caskroom/fonts
  cask_install alfred
  cask_install dash
  cask_install font-inconsolata
  cask_install libreoffice
  cask_install meld
  cask_install nvalt
  cask_install postman
  cask_install quicklook-json
  cask_install sizeup
  cask_install skype
  cask_install sweet-home3d
  cask_install thunderbird
  cask_install virtualbox
}

ensure_asdf_installed() {
  brew_install asdf
  source /usr/local/opt/asdf/asdf.sh
}

install_asdf_plugins() {
  install_asdf_plugin elixir
  install_asdf_plugin erlang
  install_asdf_plugin nodejs
  install_asdf_plugin ruby
}

install_asdf_languages() {
  asdf_install elixir 1.4.5
  asdf_install erlang 19.3
  if ! asdf list nodejs > /dev/null
  then
    bash /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf_install nodejs 8.1.2
  fi
  asdf_install ruby 2.4.1
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

cask_install() {
  package=$1
  if ! brew cask ls $package > /dev/null
  then
    brew cask install $package
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
