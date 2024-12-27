#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"
local DOTFILES_PATH="$(echo $SCRIPT_PATH | rev | cut -d'/' -f2- | rev)"

# Symlink dotfiles
if [[ $(command -v stow) != "" ]]; then
    echo "\n- GNU Stow found, symlinking dotfiles"
    local from_dir="$PWD"
    if [[ $from_dir != $DOTFILES_PATH ]]; then
      echo "\n- CWD: $PWD"
      echo "\n- Switching to $DOTFILES_PATH repo directory"
      cd "$DOTFILES_PATH"
      echo "\n- CWD: $PWD\n"
    fi

    stow -vR .


    if [[ $PWD != $from_dir ]]; then
      echo "\n- CWD: $PWD"
      echo "\n- Switching back to $from_dir"
      cd "$from_dir"
      echo "\n- CWD: $PWD"
    fi
else
    echo "\n- GNU Stow not found, run $SCRIPT_PATH/bootstrap.zsh first."
    exit 1
fi
