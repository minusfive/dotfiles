# use standard XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# wezterm shell integration
TERMINFO_DIRS="$XDG_CONFIG_HOME/wezterm/terminfo"
if [[ -f $XDG_CONFIG_HOME/wezterm/shell-integration.sh ]]; then
  source $XDG_CONFIG_HOME/wezterm/shell-integration.sh
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh cache
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/omz"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( 
    # other plugins...
    # zsh-autocomplete
    colored-man-pages
    docker
    fast-syntax-highlighting
    git
    mise
    terraform
    virtualenv
    # yarn
    zoxide
    zsh-autosuggestions
    fzf
    ohmyzsh-full-autoupdate
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable VI mode
bindkey -v
# Remove ESC delay
KEYTIMEOUT=1

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Use deduplicated (unique) path entries to maintain performance
typeset -U path
typeset -U fpath
typeset -U manpath

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Homebrew completion
if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
    path=($BREW_PREFIX/opt/coreutils/libexec/gnubin
          $BREW_PREFIX/bin
          $BREW_PREFIX/sbin
          /usr/bin
          $path)
    manpath=($BREW_PREFIX/opt/coreutils/libexec/gnuman $manpath)

    if [ -d "$BREW_PREFIX/opt/ruby/bin" ]; then
        path=($BREW_PREFIX/opt/ruby/bin
              `gem environment gemdir`/bin
              $path)
    fi
fi

# Python
path=(/usr/local/bin
      /usr/local/sbin
      $path)

# Yarn
path=($HOME/.yarn/bin
      $XDG_CONFIG_HOME/yarn/global/node_modules/.bin
      $path)

export PATH
export FPATH
export MANPATH

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Load Aliases File
if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi


[[ -f $HOME/.docker/init-zsh.sh ]] && source $HOME/.docker/init-zsh.sh || true # Added by Docker Desktop

# Configure Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

# Wezterm CLI auto-complete
if [[ -f $XDG_CONFIG_HOME/wezterm/shell-completion.zsh ]]; then
  source $XDG_CONFIG_HOME/wezterm/shell-completion.zsh
fi

# Multiplexers
export ZELLIJ_CONFIG_DIR="$XDG_CONFIG_HOME/zellij"

# Lazygit
# LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml"

# ripgrep config
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

# FZF
source <(fzf --zsh)

# Yazi - Change directory when exiting
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp" > /dev/null
}
