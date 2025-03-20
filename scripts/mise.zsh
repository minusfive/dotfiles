#!/usr/bin/env zsh
# mise dev tools installation
# See: https://mise.jdx.dev

# Exit immediately if a command fails and treat unset vars as error
set -euo pipefail

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  if [[ $(command -v mise) != "" ]]; then
    _v::log::info "Installing $(_v::fmt::u mise dev tools)"
    mise install
    mise prune

    if [[ $? = 0 ]]; then
      _v::log::ok "$(_v::fmt::u mise dev tools) installed and pruned"
    fi
  else
    _v::log::error "$(_v::fmt::u mise) not found"
    exit 1
  fi
}

