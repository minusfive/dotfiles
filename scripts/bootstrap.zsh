#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"
local BREW_BUNDLE_PATH="$SCRIPT_PATH/Brewfile"
local DOTFILES_PATH="$SCRIPT_PATH/.."
local GITIGNORE_PATH="$DOTFILES_PATH/.gitignore"

# Install Homebrew
if [[ $(command -v brew) == "" ]]; then
    echo "\n- Homebrew not installed. Attempting install..."
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $? == 0 ]]; then
        echo "\n- Homebrew installed, adding to path..."
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Install Homebrew packages and apps
if [[ $(command -v brew) != "" ]]; then
    echo "\n- Homebrew installed at $(which brew)"

    # Install desired tools, apps, etc.
    if [[ ! -f $BREW_BUNDLE_PATH ]]; then
        echo "\n- Brewfile not found"
    else
        echo "\n- Installing Homebrew bundle"
        brew bundle -v --file $BREW_BUNDLE_PATH
    fi
fi


# Install OhMyZsh
if [[ -d ${ZSH:-$HOME/.oh-my-zsh} ]]; then
    echo "\n- OhMyZsh already installed"
else
    echo "\n- Installing OhMyZsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# Install PowerLevel10K
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
    echo "\n- PowerLevel10K already installed"
else
    echo "\n- Installing PowerLevel10K"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi


# Install fast-syntax-highlighting
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting ]]; then
    echo "\n- fast-syntax-highlighting already installed"
else
    echo "\n- Installing fast-syntax-highlighting"
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi


# Install zsh-autosuggestions
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    echo "\n- zsh-autosuggestions already installed"
else
    echo "\n- Installing zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install fzf-tab
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
    echo "\n- fzf-tab already installed"
else
    echo "\n- Installing fzf-tab"
    git clone --depth=1 https://github.com/Aloxaf/fzf-tab \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# Install OhMyZsh Full-autoupdate
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate ]]; then
    echo "\n- OhMyZsh Full-autoupdate already installed"
else
    echo "\n- Installing OhMyZsh Full-autoupdate"
    git clone --depth=1 https://github.com/Pilaton/OhMyZsh-full-autoupdate.git \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
fi

source "$SCRIPT_PATH/update.zsh"
