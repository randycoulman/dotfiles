# dotfiles

My dotfiles.

These files set up bash, git, and a few other utilities.
They're likely not usable out of the box, but feel free to steal
snippets and ideas.

I manage these files using thoughtbot's [rcm](https://github.com/thoughtbot/rcm) utility.

## Setting up a new machine

1. Rename the machine so that `hostname` matches one of the `host-*`
   directories (e.g. `sudo scutil --set LocalHostName randy-automatiq`), or
   create a new `host-<hostname>` directory for it.
2. Create an SSH key and add it to GitHub.
3. Clone this repo: `git clone git@github.com:randycoulman/dotfiles.git ~/.dotfiles`
4. Run `~/.dotfiles/setupMachine.sh`.

## Homebrew packages

Shared packages are listed in `Brewfile`, which also loads
`host-<hostname>/Brewfile` if present. Run `brew bundle` (or `brew bundle check`,
`brew bundle cleanup`, etc.) from this directory.

## Language versions

Languages are managed by [mise](https://mise.jdx.dev). `setupMachine.sh` pins the
latest versions in `~/.config/mise/config.toml`, which is not tracked here;
upgrade them with `mise use -g --pin <tool>@<version>`.
