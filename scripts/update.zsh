#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"
local DOTFILES_PATH="$(echo $SCRIPT_PATH | rev | cut -d'/' -f2- | rev)"

# Apply nix-darwin configuration
if [[ $(command -v darwin-rebuild) != "" ]]; then
  echo "\n- Applying nix-darwin changes..."
  darwin-rebuild switch --flake "$DOTFILES_PATH/.config/nix-darwin#macos"

  if [[ $? == 0 ]]; then
    echo "\n- nix-darwin changes applied"
  fi
fi

# Symlink dotfiles
source "$SCRIPT_PATH/link.zsh"

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
