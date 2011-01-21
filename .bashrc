#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## PS1='[\h] \w$ '

# ================
# = Default PATH =
# ================
PATH="/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH"

# ==================
# = Homebrew Paths =
# ==================
BREW_PREFIX=$(brew --prefix)
BREW_TAPS_PREFIX="$BREW_PREFIX/opt"
# =============
# = coreutils =
# =============
PATH="$BREW_TAPS_PREFIX/coreutils/libexec/gnubin:$PATH"
MANPATH="$BREW_TAPS_PREFIX/coreutils/libexec/gnuman:$MANPATH"
# ==============================
# = ASDF - https://asdf-vm.com =
# ==============================
source "$BREW_TAPS_PREFIX/asdf/asdf.sh"

# Custom Paths
# PATH="/usr/local/share/aclocal:/usr/local/share/python:$PATH" # Python
# PATH="$HOME/.cabal/bin:$PATH" # Haskell

# ==========
# = MAMP =
# ==========
# PATH="/Applications/MAMP/Library/bin/:/Applications/MAMP/bin/php5/bin/:$PATH"

# ==========
# = Colors =
# ==========
export CLICOLOR=1
export LC_CTYPE=en_US.UTF-8
export TERM=xterm-color
export GREP_COLOR='1;32'

if [ "$TERM" != "dumb" ]; then
  # LS colorize, group directories, append slashes ('/')
  export LS_OPTIONS='--group-directories-first -p --color=always'
  eval `dircolors ~/.dir_colors`
fi

# ===========
# = Editors =
# ===========
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export SVN_EDITOR='nvim'

# =====================
# = Load Aliases File =
# =====================
[[ -f ~/.aliases ]] && source ~/.aliases

# ===============
# = ImageMagick =
# ===============
# export MAGICK_HOME="/usr/local/ImageMagick-6.6.3"
# PATH="$MAGICK_HOME/bin:$PATH"
# export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"

# =======================
# = Create basic prompt =
# =======================
# export PS1=$'\\r\\n\\[\e[00;45;30m\\] \\t \\[\e[00;100;30m\\] \\h \\[\e[00;47;30m\\] \\w \\[\e[00;40;37m\\]\\r\\n\\[\e[00;40;92m\\]\xe2\x9d\xaf\\[\e[00;40;37m\\] '
export PS1=$'\\r\\n\\[\e[00;45;30m\\] \\t \\[\e[00;40;37m\\]\\[\e[00;40;92m\\] \xe2\x9d\xaf\\[\e[00;40;37m\\] '

# ================================
# = Load auto-completion scripts =
# ================================
# Homebrew Bash Completion
if type brew &>/dev/null; then
  for COMPLETION in "$BREW_PREFIX/etc/bash_completion.d/"*
  do
    [[ -f $COMPLETION ]] && source $COMPLETION
  done
  if [[ -f "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]];
  then
    source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
  fi
  if [[ -f "$BREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]];
  then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="verbose"
    export GIT_PS1_SHOWCOLORHINTS=true
    # export PROMPT_COMMAND=$'__git_ps1 "\\r\\n\\[\e[00;45;30m\\] \\t \\[\e[00;100;30m\\] \\h \\[\e[00;47;30m\\] \\w \\[\e[00;40;37m\\]" "\\r\\n\\[\e[00;40;92m\\]\xe2\x9d\xaf\\[\e[00;40;37m\\] " "\\[\e[00;42;30m\\] \xe2\x99\x86 \\[\e[00;40;37m\\] %s"'
    export PROMPT_COMMAND=$'__git_ps1 "\\r\\n\\[\e[00;45;30m\\] \\t \\[\e[00;40;37m\\]" " \\[\e[00;40;92m\\]\xe2\x9d\xaf\\[\e[00;40;37m\\] " "\\[\e[00;42;30m\\] \xe2\x99\x86 \\[\e[00;40;37m\\] %s"'
  fi
fi

# ===============
# = Android SDK =
# ===============
# export ANDROID_HOME="$HOME/Library/Android/sdk/platform-tools"
# PATH="$ANDROID_HOME:$PATH"

# ===================
# = Shopify Themkit =
# ===================
# PATH="$HOME/.themekit:$PATH"

# ===========
# = libxml2 =
# ===========
# export PATH="$(brew --prefix libxml2)/bin:$PATH"
# export LDFLAGS="-L$(brew --prefix libxml2)/lib"
# export CPPFLAGS="-I$(brew --prefix libxml2)/include"
# export PKG_CONFIG_PATH="$(brew --prefix libxml2)/lib/pkgconfig"

# ===========
# = libxslt =
# ===========
# export PATH="$(brew --prefix libxslt)/bin:$PATH"
# export LDFLAGS="-L$(brew --prefix libxslt)/lib"
# export CPPFLAGS="-I$(brew --prefix libxslt)/include"
# export PKG_CONFIG_PATH="$(brew --prefix libxslt)/lib/pkgconfig"
