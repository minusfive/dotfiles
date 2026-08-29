#!/usr/bin/env zsh
# Homebrew installation helper

# Exit immediately if a command fails and treat unset vars as error
set -euo pipefail

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
    local __context="BREW"
    local __proceed="$__brew"

    if [[ "$__proceed" == true ]]; then
        echo "\n"
        _v_log_info $__context "Installing $(_v_fmt_u Homebrew)..."
        _v_confirm_proceed
    fi

    if [[ "$__proceed" != true ]]; then
        echo "\n"
        _v_log_warn $__context "Skipping $(_v_fmt_u Homebrew) installation"
        return 0
    fi

    # Install Homebrew
    if [[ $(command -v brew) == "" ]]; then
        echo "\n"
        _v_log_info $__context "$(_v_fmt_u Homebrew) not installed. Attempting install..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [[ $? == 0 ]]; then
            _v_log_ok $__context "$(_v_fmt_u Homebrew) installed, adding to path..."
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "\n"
        _v_log_ok $__context "$(_v_fmt_u Homebrew) installed at $(which brew)"
    fi
}
