#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  local __dotfiles_scripts_dir="$(dirname "$1")"
  local __dotfiles_dir="$(dirname "$__dotfiles_scripts_dir")"

  # Apply nix-darwin configuration
  if [[ $(command -v darwin-rebuild) != "" ]]; then
    echo "\n- Applying nix-darwin changes..."
    darwin-rebuild switch --flake "$__dotfiles_dir#mac"

    if [[ $? == 0 ]]; then
      echo "\n- nix-darwin changes applied"
    fi
  fi

  # Symlink dotfiles
  source "$__dotfiles_scripts_dir/link.zsh"

  # Update OhMyZsh, plugins and themes
  zsh "$ZSH/tools/upgrade.sh"

  # Rebuild bat cache
  if [[ $(command -v bat) != "" ]]; then
    echo "\n- Rebuilding bat cache..."
    bat cache --build
  fi

  # Update Yazi packages
  if [[ $(command -v ya) != "" ]]; then
    echo "\n- Updating Yazi packages..."
    ya pack -u
  fi

  # Update NPM packages
  if [[ $(command -v npm) != "" ]]; then
    echo "\n- Install + update NPM packages..."
    npm install -g npm@latest neovim
  fi

  echo "\n- Cleaning up zsh completion..."
  rm -f "$ZSH_COMPDUMP"

  echo "\n- Update complete, sourcing ~/.zshrc..."
  source "$HOME/.zshrc"

} $(realpath $0)

