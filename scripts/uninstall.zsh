#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Guardrail
echo <<-EOM
%F{yellow}WARNING!%f
This may be dangerous! Open this script and uncomment accordingly if really desired
EOM
exit 0

# # Immediately invoked anonymous function used to contain variables and functions in a local scope
# if [[ $(command -v nix) != "" ]]; then
#   # Uninstall nix-darwin
#   nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
# fi
#
# # Uninstall Nix
# if [[ -x "/nix/nix-installer" ]]; then
#   echo "\n- Uninstalling Nix..."
#
#   /nix/nix-installer uninstall
#
#   if [[ $? == 0 ]]; then
#     echo "\n- Nix uninstalled"
#   fi
# fi
#
# echo "\n- Uninstall complete"
