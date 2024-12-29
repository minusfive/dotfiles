#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

local SCRIPT_PATH="$(dirname "$(realpath $0)")"
local DOTFILES_PATH="$(echo $SCRIPT_PATH | rev | cut -d'/' -f2- | rev)"

# Install nix
if [[ $(command -v nix) == "" ]]; then
  echo "\n- Nix not installed. Attempting install..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

  if [[ $? == 0 ]]; then
    echo "\n- Nix installed, starting service..."
    # Start the nix daemon without restarting the shell
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi
else
  echo "\n- Nix already installed"
fi

# Install nix-darwin
if [[ $(command -v nix) != "" && $(command -v darwin-rebuild) == "" ]]; then
  echo "\n- nix-darwin not installed, installing..."
  nix run nix-darwin -- switch --flake "$DOTFILES_PATH#macos"

  if [[ $? == 0 ]]; then
    echo "\n- nix-darwin installed"
  fi
fi

# TODO: Move to nix
# Install OhMyZsh
if [[ -d ${ZSH:-$HOME/.oh-my-zsh} ]]; then
  echo "\n- OhMyZsh already installed"
else
  echo "\n- Installing OhMyZsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# TODO: Move to nix
# Install PowerLevel10K
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
  echo "\n- PowerLevel10K already installed"
else
  echo "\n- Installing PowerLevel10K"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# TODO: Move to nix
# Install fast-syntax-highlighting
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting ]]; then
  echo "\n- fast-syntax-highlighting already installed"
else
  echo "\n- Installing fast-syntax-highlighting"
  git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi

# TODO: Move to nix
# Install zsh-autosuggestions
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
  echo "\n- zsh-autosuggestions already installed"
else
  echo "\n- Installing zsh-autosuggestions"
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# TODO: Move to nix
# Install fzf-tab
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
  echo "\n- fzf-tab already installed"
else
  echo "\n- Installing fzf-tab"
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# TODO: Move to nix
# Install fzf-tab-source
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab-source ]]; then
  echo "\n- fzf-tab-source already installed"
else
  echo "\n- Installing fzf-tab-source"
  git clone --depth=1 https://github.com/Freed-Wu/fzf-tab-source \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab-source
fi

# TODO: Move to nix
# Install OhMyZsh Full-autoupdate
if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate ]]; then
  echo "\n- OhMyZsh Full-autoupdate already installed"
else
  echo "\n- Installing OhMyZsh Full-autoupdate"
  git clone --depth=1 https://github.com/Pilaton/OhMyZsh-full-autoupdate.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
fi

source "$SCRIPT_PATH/update.zsh"
