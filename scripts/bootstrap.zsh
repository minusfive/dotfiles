#!/usr/bin/env zsh

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Exit immediately if a command fails and treat unset vars as error
set -eu

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  local __dotfiles_scripts_dir="$(dirname "$1")"
  local __dotfiles_dir="$(dirname "$__dotfiles_scripts_dir")"

	export HOMEBREW_BUNDLE_FILE_GLOBAL="$__dotfiles_scripts_dir/Brewfile"

  function log_info() { print -P "%F{blue}󰬐  $1%f" }
  function log_ok() { print -P "%F{green}󰄲  $1%f" }
  function log_error() { print -P "%F{red}󰡅  $1%f" }

	# Install Homebrew
	if [[ $(command -v brew) == "" ]]; then
	    log_info "%UHomebrew%u not installed. Attempting install..."
	    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	    if [[ $? == 0 ]]; then
		log_ok "%UHomebrew%u installed, adding to path..."
		(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
	    fi
	else
		log_ok "%UHomebrew%u installed at $(which brew)"
	fi


  echo "\n"
	# Install Homebrew packages and apps
	if [[ $(command -v brew) != "" ]]; then
		if [[ ! -f $HOMEBREW_BUNDLE_FILE_GLOBAL ]]; then
			log_error "%UBrewfile%u not found"
			exit 1
		fi

		log_info "Installing %UHomebrew bundle%u"
		brew bundle -v --global --cleanup --zap

		if [[ $? == 0 ]]; then
			log_ok "%UHomebrew bundle%u installed"
		fi
	fi


  echo "\n"
  # Symlink dotfiles
  if [[ $(command -v stow) != "" ]]; then
    log_info "%UGNU Stow%u found, symlinking dotfiles"

    # CD to dotfiles dir and then back when done
    local __from_dir="$PWD"

    if [[ $__from_dir != $__dotfiles_dir ]]; then
      echo "- CWD: $PWD"
      echo "- Switching to $__dotfiles_dir"
      cd "$__dotfiles_dir"
      echo "- CWD: $PWD"
    fi

    stow -vR .

    if [[ $PWD != $__from_dir ]]; then
      echo "- CWD: $PWD"
      echo "- Switching back to $__from_dir"
      cd "$__from_dir"
      echo "- CWD: $PWD"
    fi
  else
    log_error "%UGNU Stow%u not found"
    exit 1
  fi


  echo "\n"
  # Configure OS settings
  if [[ $(defaults read org.hammerspoon.Hammerspoon MJConfigFile 2> /dev/null) == "~/.config/hammerspoon/init.lua" ]]; then
    log_ok "%UHammerspoon%u config dir set to XDG"
  else
    log_info "Configuring %UHammerspoon%u to read config from XDG dir"
    defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

    if [[ $? == 0 ]]; then
      log_ok "%UHammerspoon%u config dir set to XDG"
    fi
  fi

  echo "\n"
  # Install OhMyZsh
  if [[ -d ${ZSH:-$HOME/.oh-my-zsh} ]]; then
    log_ok "%UOhMyZsh%u already installed"
  else
    log_info "Installing %UOhMyZsh%u"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    if [[ $? == 0 ]]; then
      log_ok "%UOhMyZsh%u installed"
    fi
  fi

  echo "\n"
  # Install PowerLevel10K
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
    log_ok "%UPowerLevel10K%u already installed"
  else
    log_info "Installing %UPowerLevel10K%u"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    if [[ $? == 0 ]]; then
      log_ok "%UPowerLevel10K%u installed"
    fi
  fi

  echo "\n"
  # Install fast-syntax-highlighting
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting ]]; then
    log_ok "%Ufast-syntax-highlighting%u already installed"
  else
    log_info "Installing %Ufast-syntax-highlighting%u"
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
      ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    if [[ $? == 0 ]]; then
      log_ok "%Ufast-syntax-highlighting%u installed"
    fi
  fi

  echo "\n"
  # Install zsh-autosuggestions
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    log_ok "%Uzsh-autosuggestions%u already installed"
  else
    log_info "Installing %Uzsh-autosuggestions%u"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    if [[ $? == 0 ]]; then
      log_ok "%Ufast-syntax-highlighting%u installed"
    fi
  fi

  echo "\n"
  # Install fzf-tab
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
    log_ok "%Ufzf-tab%u already installed"
  else
    log_info "Installing %Ufzf-tab%u"
    git clone --depth=1 https://github.com/Aloxaf/fzf-tab \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

    if [[ $? == 0 ]]; then
      log_ok "%Ufzf-tab%u installed"
    fi
  fi

  echo "\n"
  # Install fzf-tab-source
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab-source ]]; then
    log_ok "%Ufzf-tab-source%u already installed"
  else
    log_info "Installing %Ufzf-tab-source%u"
    git clone --depth=1 https://github.com/Freed-Wu/fzf-tab-source \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab-source

    if [[ $? == 0 ]]; then
      log_ok "%Ufzf-tab-source%u installed"
    fi
  fi

  echo "\n"
  # Install zsh-vi-mode
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode ]]; then
    log_ok "%Uzsh-vi-mode%u already installed"
  else
    log_info "Installing %Uzsh-vi-mode%u"
    git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

    if [[ $? == 0 ]]; then
      log_ok "%Uzsh-vi-mode%u installed"
    fi
  fi

  echo "\n"
  # Install OhMyZsh Full-autoupdate
  if [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate ]]; then
    log_ok "%UOhMyZsh Full-autoupdate%u already installed"
  else
    log_info "Installing %UOhMyZsh Full-autoupdate%u"
    git clone --depth=1 https://github.com/Pilaton/OhMyZsh-full-autoupdate.git \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate

    if [[ $? == 0 ]]; then
      log_ok "%UOhMyZsh Full-autoupdate%u installed"
    fi
  fi

	# From https://github.com/ohmyzsh/ohmyzsh/blob/d82669199b5d900b50fd06dd3518c277f0def869/lib/cli.zsh#L668-L676
	function __reload {
		# Delete current completion cache
		(command rm -f $_comp_dumpfile $ZSH_COMPDUMP) 2> /dev/null

		# Old zsh versions don't have ZSH_ARGZERO
		local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}"

		# Check whether to run a login shell
		[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
	}

	echo "\n"
	log_ok "Update complete, reloading shell..."
	__reload
} $(realpath $0)

