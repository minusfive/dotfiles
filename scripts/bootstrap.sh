#!/bin/zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu


if [[ $(command -v brew) != "" ]]; then
    echo "- Homebrew installed at $(which brew). Attempting upgrade..."
    brew upgrade
    
    if [[ $? == 0 ]]; then
	echo "- Everything up to date"
    fi
else
    echo "- Homebrew not installed. Attempting install..."
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


    echo "- Homebrew installed, adding to path..."
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

SCRIPT_PATH="$(dirname "$(realpath $0)")"
BREW_BUNDLE_PATH="$SCRIPT_PATH/Brewfile"

if [[ ! -f $BREW_BUNDLE_PATH ]]; then
    echo "- Brewfile not found"
else
    echo "- Installing Homebrew bundle"
    brew bundle --file $BREW_BUNDLE_PATH
fi
