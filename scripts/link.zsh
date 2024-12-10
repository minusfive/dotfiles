#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Symlink dotfiles
if [[ $(command -v stow) != "" ]]; then
    echo "\n- GNU Stow found, symlinking dotfiles"
    stow -vR .
else
    echo "\n- GNU Stow not found, run the bootstrap script first."
    exit 1
fi
