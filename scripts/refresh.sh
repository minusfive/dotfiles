# Clanup zsh completion and reload oh-my-zsh
brew cleanup && rm -f "$ZSH_COMPDUMP" && omz reload

# Update OhMyZsh, plugins and themes
zsh "$HOME/.oh-my-zsh/tools/upgrade.sh"

# Rebuild bat cache
if [[ $(command -v bat) != "" ]]; then
  echo "- Rebuilding bat cache"
  bat cache --build
fi

# Symlink dotfiles
if [[ $(command -v stow) != "" ]]; then
  echo "- GNU Stow found, symlinking dotfiles"
  stow -vR .
else
  echo "- GNU Stow not found."
fi
