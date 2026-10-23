#!/bin/bash
#
# Sets up a new machine. Clone this repo to ~/.dotfiles first, then run this
# script from there. It is safe to re-run.

set -euo pipefail

DOTFILES="$HOME/.dotfiles"
BREW_BASH=/opt/homebrew/bin/bash

main() {
  ensure_host_directory_exists
  ensure_brew_installed
  install_brew_packages
  setup_dotfiles
  set_login_shell
  install_languages
  install_claude_code
  ensure_git_message_exists
}

ensure_host_directory_exists() {
  local host_dir
  host_dir="$DOTFILES/host-$(hostname)"
  if ! [ -d "$host_dir" ]
  then
    echo "No host directory found at $host_dir."
    echo "Rename this machine (e.g. sudo scutil --set LocalHostName <name>)"
    echo "or create a host-$(hostname) directory, then re-run this script."
    exit 1
  fi
}

ensure_brew_installed() {
  if ! [ -x /opt/homebrew/bin/brew ]
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_brew_packages() {
  ( cd "$DOTFILES"; brew bundle )
}

setup_dotfiles() {
  ( cd "$DOTFILES"; rcup rcrc; rcup )
}

set_login_shell() {
  if ! grep -qx "$BREW_BASH" /etc/shells
  then
    echo "$BREW_BASH" | sudo tee -a /etc/shells > /dev/null
  fi
  if [ "$(dscl . -read "$HOME" UserShell | awk '{print $2}')" != "$BREW_BASH" ]
  then
    chsh -s "$BREW_BASH"
  fi
}

install_languages() (
  cd "$HOME"
  # kerl reads its build options from the environment, which may predate them
  . "$DOTFILES/bashrc.d/elixir"
  asdf_install erlang
  asdf_install elixir latest_elixir_for_pinned_otp
  asdf_install nodejs
  install_git_mob
)

install_claude_code() {
  if ! [ -x "$HOME/.local/bin/claude" ]
  then
    curl -fsSL https://claude.ai/install.sh | bash
  fi
}

ensure_git_message_exists() {
  # git-mob writes co-authors here; git refuses to commit if it's missing
  touch "$HOME/.gitmessage"
}

install_git_mob() {
  if ! asdf which git-mob &>/dev/null
  then
    asdf exec npm install -g git-mob
    asdf reshim nodejs
  fi
}

asdf_install() {
  local tool=$1 version_cmd=${2:-asdf latest}
  asdf plugin add "$tool"
  if ! asdf current "$tool" &>/dev/null
  then
    asdf set -u "$tool" "$($version_cmd "$tool")"
  fi
  asdf install "$tool"
}

latest_elixir_for_pinned_otp() {
  local otp_major
  otp_major=$(asdf current --no-header erlang | awk '{ print $2 }' | cut -d. -f1)
  asdf list all elixir | grep -E -- "^[0-9.]+-otp-$otp_major\$" | tail -1
}

main
