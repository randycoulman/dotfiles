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

install_languages() {
  mise_use_latest erlang
  if ! mise_configured elixir
  then
    local otp_major
    otp_major=$(mise latest erlang --installed | cut -d. -f1)
    mise use -g --pin "elixir@$(latest_elixir_for_otp "$otp_major")"
  fi
  mise_use_latest node
  mise_use_latest npm:git-mob
  mise install
}

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

# Pins the latest version in the global mise config, unless the tool is already
# configured there. Upgrade versions manually with `mise use -g --pin`.
mise_use_latest() {
  local tool=$1
  if ! mise_configured "$tool"
  then
    mise use -g --pin "$tool@latest"
  fi
}

mise_configured() {
  local tool=$1
  grep -qE "^\"?$tool\"? = " "$HOME/.config/mise/config.toml" 2>/dev/null
}

latest_elixir_for_otp() {
  local otp_major=$1
  mise ls-remote elixir | grep -E -- "^[0-9.]+-otp-$otp_major\$" | tail -1
}

main
