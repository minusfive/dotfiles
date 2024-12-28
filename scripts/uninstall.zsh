#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

if [[ $(command -v nix) != "" ]]; then
  # Uninstall nix-darwin
  nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
fi



# Uninstall Nix
if [[ -x "/nix/nix-installer" ]]; then
    echo "\n- Uninstalling Nix..."

    /nix/nix-installer uninstall

    if [[ $? == 0 ]]; then
        echo "\n- Nix uninstalled"
    fi
fi


echo "\n- Uninstall complete"

