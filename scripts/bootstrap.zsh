#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  local __dotfiles_scripts_dir="$(dirname "$1")"
  local __dotfiles_dir="$(dirname "$__dotfiles_scripts_dir")"
  local __flake_system="personal"

  function __log_info() { print -P "%F{blue}󰬐  $1%f" }
  function __log_ok() { print -P "%F{green}󰄲  $1%f" }
  function __log_error() { print -P "%F{red}󰡅  $1%f" }

  # Install nix
  if [[ $(command -v nix) == "" ]]; then
    echo "\n"
    __log_info "%UNix%u not installed. Attempting install..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

    if [[ $? == 0 ]]; then
      __log_ok "%UNix%u installed, starting service..."

      # Start the nix daemon without restarting the shell
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  else
    __log_ok "%UNix%u already installed"
  fi

  # Install nix-darwin
  if [[ $(command -v nix) != "" && $(command -v darwin-rebuild) == "" ]]; then
    echo "\n"
    __log_info "%Unix-darwin%u not installed, installing..."
    nix run nix-darwin -- switch --flake "$__dotfiles_dir#$__flake_system"

    if [[ $? == 0 ]]; then
      __log_ok "%Unix-darwin%u installed"
    fi
  else
    __log_ok "%Unix-darwin%u already installed"
  fi

  # Apply nix-darwin configuration
  if [[ $(command -v darwin-rebuild) != "" ]]; then
    echo "\n"
    __log_info "Applying %Unix-darwin%u changes..."
    darwin-rebuild switch --flake "$__dotfiles_dir#$__flake_system"

    if [[ $? == 0 ]]; then
      __log_ok "%Unix-darwin%u changes applied"
    fi
  fi

  # Symlink dotfiles
  if [[ $(command -v stow) != "" ]]; then
    echo "\n"
    __log_info "%UGNU Stow%u found, symlinking dotfiles"

    # CD to dotfiles dir and then back when done
    local __from_dir="$PWD"

    if [[ $__from_dir != $__dotfiles_dir ]]; then
      echo "- CWD: $PWD"
      echo "- Switching to $__dotfiles_dir"
      cd "$__dotfiles_dir"
      echo "- CWD: $PWD"
    fi

    stow -vR .

    if [[ $PWD != $__from_dir ]]; then
      echo "- CWD: $PWD"
      echo "- Switching back to $__from_dir"
      cd "$__from_dir"
      echo "- CWD: $PWD"
    fi
  else
    echo "\n"
    __log_error "%UGNU Stow%u not found"
    exit 1
  fi

  # Update Yazi packages
  if [[ $(command -v ya) != "" ]]; then
    echo "\n"
    __log_info "Updating %UYazi%u packages..."
    ya pack -u
  fi

  # TODO: Reactivate?
  # Update NPM packages
  # if [[ $(command -v npm) != "" ]]; then
  #   echo "\n- Install + update NPM packages..."
  #   npm install -g npm@latest neovim
  # fi

  # From https://github.com/ohmyzsh/ohmyzsh/blob/d82669199b5d900b50fd06dd3518c277f0def869/lib/cli.zsh#L668-L676
  function __reload {
    # Delete current completion cache
    (command rm -f $_comp_dumpfile $ZSH_COMPDUMP) 2> /dev/null

    # Old zsh versions don't have ZSH_ARGZERO
    local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}"
    # Check whether to run a login shell
    [[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
  }

  echo "\n"
  __log_ok "Update complete, reloading shell..."
  __reload
} $(realpath $0)

