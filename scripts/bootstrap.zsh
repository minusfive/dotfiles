#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  local __dotfiles_scripts_dir="$(dirname "$1")"
  local __dotfiles_dir="$(dirname "$__dotfiles_scripts_dir")"
  local __flake_system="personal"

  # Install nix
  if [[ $(command -v nix) == "" ]]; then
    echo "\n- Nix not installed. Attempting install..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

    if [[ $? == 0 ]]; then
      echo "\n- Nix installed, starting service..."

      # Start the nix daemon without restarting the shell
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  else
    echo "\n- Nix already installed"
  fi

  # Install nix-darwin
  if [[ $(command -v nix) != "" && $(command -v darwin-rebuild) == "" ]]; then
    echo "\n- nix-darwin not installed, installing..."
    nix run nix-darwin -- switch --flake "$__dotfiles_dir#$__flake_system"

    if [[ $? == 0 ]]; then
      echo "\n- nix-darwin installed"
    fi
  else
    echo "\n- nix-darwin already installed"
  fi

  # Apply nix-darwin configuration
  if [[ $(command -v darwin-rebuild) != "" ]]; then
    echo "\n- Applying nix-darwin changes..."
    darwin-rebuild switch --flake "$__dotfiles_dir#$__flake_system"

    if [[ $? == 0 ]]; then
      echo "\n- nix-darwin changes applied"
    fi
  fi

  # Symlink dotfiles
  if [[ $(command -v stow) != "" ]]; then
    echo "\n- GNU Stow found, symlinking dotfiles"

    # CD to dotfiles dir and then back when done
    local __from_dir="$PWD"

    if [[ $__from_dir != $__dotfiles_dir ]]; then
      echo "\n- CWD: $PWD"
      echo "\n- Switching to $__dotfiles_dir"
      cd "$__dotfiles_dir"
      echo "\n- CWD: $PWD\n"
    fi

    stow -vR .

    if [[ $PWD != $__from_dir ]]; then
      echo "\n- CWD: $PWD"
      echo "\n- Switching back to $__from_dir"
      cd "$__from_dir"
      echo "\n- CWD: $PWD"
    fi
  else
    echo "\n- GNU Stow not found"
    exit 1
  fi

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
  # if [[ $(command -v npm) != "" ]]; then
  #   echo "\n- Install + update NPM packages..."
  #   npm install -g npm@latest neovim
  # fi

  echo "\n- Cleaning up zsh completion..."
  rm -f "$ZSH_COMPDUMP"

  echo "\n- Update complete, sourcing ~/.zshrc..."
  source "$XDG_CONFIG_HOME/zsh/.zshrc"



} $(realpath $0)

