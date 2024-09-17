#!/usr/bin/env zsh

# Update OhMyZsh, plugins and themes
zsh "$ZSH/tools/upgrade.sh"

# Rebuild bat cache
if [[ $(command -v bat) != "" ]]; then
  echo "\n- Rebuilding bat cache"
  bat cache --build
fi

# Symlink dotfiles
if [[ $(command -v stow) != "" ]]; then
  echo "\n- GNU Stow found, symlinking dotfiles"
  stow -vR .
else
  echo "\n- GNU Stow not found."
fi

# Update Yazi packages
if [[ $(command -v ya) != "" ]]; then
  echo "\n- Updating Yazi packages"
  ya pack -u
fi

# Cleanup zsh completion and reload zsh
echo "\n- Cleaning up zsh completion and reloading zsh session"
brew cleanup && rm -f "$ZSH_COMPDUMP" && source "$HOME/.zshrc"
