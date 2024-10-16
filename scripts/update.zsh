#!/usr/bin/env zsh

# Symlink dotfiles
if [[ $(command -v stow) != "" ]]; then
    echo "\n- GNU Stow found, symlinking dotfiles"
    stow -vR .
else
    echo "\n- GNU Stow not found, run the bootstrap script first."
    exit 1
fi

# Update OhMyZsh, plugins and themes
zsh "$ZSH/tools/upgrade.sh"


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

# Cleanup zsh completion and reload zsh
echo "\n- Cleaning up zsh completion and reloading zsh session"
rm -f "$ZSH_COMPDUMP" && source "$HOME/.zshrc"
