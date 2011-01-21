#!/bin/bash

# if running bash & ~/.bashrc exists include it
[ -n "$BASH_VERSION" ] && [ -f ~/.bashrc ] && . ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

