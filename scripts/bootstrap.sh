#!/bin/zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"
local BREW_BUNDLE_PATH="$SCRIPT_PATH/Brewfile"
local DOTFILES_PATH="$SCRIPT_PATH/.."
local GITIGNORE_PATH="$DOTFILES_PATH/.gitignore"

# Install or update Homebrew
if [[ $(command -v brew) != "" ]]; then
    echo "- Homebrew installed at $(which brew). Attempting upgrade..."
    brew upgrade
    if [[ $? == 0 ]]; then
      echo "- Everything up to date"
    fi
else
    echo "- Homebrew not installed. Attempting install..."
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? == 0 ]]; then
      echo "- Homebrew installed, adding to path..."
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Install desired tools, apps, etc.
if [[ ! -f $BREW_BUNDLE_PATH ]]; then
    echo "- Brewfile not found"
else
    echo "- Installing Homebrew bundle"
    brew bundle -v --file $BREW_BUNDLE_PATH
fi

# Install OhMyZsh
if [[ -d $HOME/.oh-my-zsh ]]; then
    echo "- OhMyZsh already installed"
else
    echo "- Installing OhMyZsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install PowerLevel10K
if [[ -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    echo "- PowerLevel10K already installed"
else
    echo "- Installing PowerLevel10K"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install fast-syntax-highlighting
if [[ -d $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]]; then
    echo "- fast-syntax-highlighting already installed"
else
    echo "- Installing fast-syntax-highlighting"
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi


# Install zsh-autosuggestions
if [[ -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    echo "- zsh-autosuggestions already installed"
else
    echo "- Installing zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

