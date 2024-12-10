#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"


# Symlink dotfiles
source "$SCRIPT_PATH/link.zsh"


# Update OhMyZsh, plugins and themes
zsh "$ZSH/tools/upgrade.sh"


# Upgrade Homebrew, packages and apps
if [[ $(command -v brew) != "" ]]; then
    echo "\n- Homebrew installed at $(which brew)"

    if [[ $(brew tap | grep "buo/cask-upgrade" -c) == 0 ]]; then
        echo "\nbrew-cask-upgrade not found; attempting install..."
        brew tap buo/cask-upgrade
    fi

    if [[ $(brew tap | grep "buo/cask-upgrade" -c) == 1 ]]; then
        echo "\nbrew-cask-upgrade found; attempting to upgrade Homebrew, packages and apps..."
        brew cu
    fi

    if [[ $? == 0 ]]; then
        echo "\n- Everything up to date"
    fi

    brew cleanup
fi


# Rebuild bat cache
if [[ $(command -v bat) != "" ]]; then
    echo "\n- Rebuilding bat cache"
    bat cache --build
fi


# Update Yazi packages
if [[ $(command -v ya) != "" ]]; then
    echo "\n- Updating Yazi packages"
    ya pack -u
fi


# Update NPM packages
if [[ $(command -v npm) != "" ]]; then
    echo "\n- Install + update NPM packages"
    npm install -g npm@latest neovim
fi


# Cleanup zsh completion and reload zsh
echo "\n- Cleaning up zsh completion and reloading zsh session"
rm -f "$ZSH_COMPDUMP" && source "$HOME/.zshrc"


echo "\n- Update complete!"

