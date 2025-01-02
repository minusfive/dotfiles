# https://nix-community.github.io/home-manager/options.xhtml
{
  pkgs,
  ...
}:
{
  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.11";

  # Use standard XDG directories
  xdg.enable = true;
  home.preferXdgDirectories = true;

  home.sessionVariables = {
    EDITOR = "nvim";

    # Disable Next.js telemetry
    # https://nextjs.org/telemetry
    NEXT_TELEMETRY_DISABLED = 1;
  };

  home.shellAliases = {
    # Use `eza` instead of `ls` with some default options
    l = "eza --color=auto --icons=auto --classify=auto --group-directories-first --header --time-style=long-iso";
    ls = "l";
    # Same as above + show all files except "." & ".."
    la = "ls --all";
    # Same as above + long list + use powers of 1000 vs. 1024 + ISO time
    ll = "la --long";
    # Same as above + sort by modification time
    lm = "ll --modified --sort=modified";
    # Same as 'll' above + output as a tree
    lt = "ll --tree --level=2 ";
  };

  # Apps we want installed
  home.packages = with pkgs; [
    coreutils
    gum
    neovim-node-client
    nixd
    nixfmt-rfc-style
    nodejs_23 # Besides the obvious needed by some LSPs and Copilot
    stow
    ruby
    rustup
    vivid
    wget
  ];

  # TODO: Install Cactpuccin theme(s)
  programs.bat.enable = true; # `cat` replacement
  programs.eza.enable = true; # `ls` replacement
  programs.fd.enable = true; # `find` replacement
  programs.fzf.enable = true; # Fuzzy finder
  programs.go.enable = true;
  programs.htop.enable = true; # `top` replacement
  programs.jq.enable = true; # JSON processor
  programs.lazygit.enable = true; # Git Terminal UI
  programs.neovim.enable = true; # Preferred text editor
  programs.ripgrep.enable = true; # `grep` replacement
  programs.yazi.enable = true; # File manager in terminal
  programs.zoxide.enable = true; # `cd` replacement

  programs.git = {
    enable = true;
    diff-highlight.enable = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;

    history = {
      expireDuplicatesFirst = true;
    };

    autosuggestion = {
      enable = true;
    };

    # These are similar to aliases, but they expand the command on submission
    # so the full command is retained in history and is more shareable
    zsh-abbr = {
      enable = true;
      abbreviations = {
        # Make RM interactive + verbose + protect root
        rm = "rm --preserve-root -iv";
        # Make LN interactive + verbose
        ln = "ln -iv";
        # Make MV interactive + verbose
        mv = "mv -iv";
        # Make CP interactive + verbose
        cp = "cp -iv";

        # Terminal control
        t = "wezterm cli set-tab-title";
        wt = "wezterm cli set-window-title";
        q = "exit";
        c = "clear";

        # SSH
        # alias ssh="ssh -X"

        # Cleanup ripgrep output for piping
        rgc = "rg --color=never --no-heading --no-line-number --no-filename";

        # Keep bunzip2 decompressed files
        bunzip2 = "bunzip2 -k";

        # Editor
        v = "nvim";

        # use bat instead of cat, for previews, etc.
        cat = "bat";

        # Yazi
        f = "yy";

        # LazyGit
        lg = "lazygit";
      };
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "colored-man-pages"
        "docker"
        "git"
        "mise"
        "terraform"
        "virtualenv"
        "zoxide"
        "fzf"
      ];

      extraConfig = ''
        # Uncomment one of the following lines to change the auto-update behavior
        # zstyle ':omz:update' mode disabled  # disable automatic updates
        # zstyle ':omz:update' mode auto      # update automatically without asking
        zstyle ':omz:update' mode reminder  # just remind me to update when it's time

        # Uncomment the following line to change how often to auto-update (in days).
        zstyle ':omz:update' frequency 13
      '';
    };

    # oh-my-zsh configuration variables
    localVariables = {
      # Uncomment the following line to use case-sensitive completion.
      # CASE_SENSITIVE="true";

      # Uncomment the following line to use hyphen-insensitive completion.
      # Case-sensitive completion must be off. _ and - will be interchangeable.
      # HYPHEN_INSENSITIVE="true";

      # Uncomment the following line if pasting URLs and other text is messed up.
      # DISABLE_MAGIC_FUNCTIONS="true";

      # Uncomment the following line to disable colors in ls.
      # DISABLE_LS_COLORS="true";

      # Uncomment the following line to disable auto-setting terminal title.
      # DISABLE_AUTO_TITLE="true";

      # Uncomment the following line to enable command auto-correction.
      ENABLE_CORRECTION = "true";

      # Uncomment the following line to display red dots whilst waiting for completion.
      # You can also set it to another string to have that shown instead of the default red dots.
      # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f";
      # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
      COMPLETION_WAITING_DOTS = "true";

      # Uncomment the following line if you want to disable marking untracked files
      # under VCS as dirty. This makes repository status check for large repositories
      # much, much faster.
      # DISABLE_UNTRACKED_FILES_DIRTY="true";

      # Uncomment the following line if you want to change the command execution time
      # stamp shown in the history command output.
      # You can set one of the optional three formats:
      # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
      # or set a custom format using the strftime function format specifications,
      # see 'man strftime' for details.
      HIST_STAMPS = "yyyy-mm-dd";
    };

    sessionVariables = {
      # Multiplexers
      ZELLIJ_CONFIG_DIR = "$XDG_CONFIG_HOME/zellij";
      # Lazygit
      LG_CONFIG_FILE = "$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml";
      # ripgrep config
      RIPGREP_CONFIG_PATH = "$XDG_CONFIG_HOME/ripgrep/.ripgreprc";
      # Colorize LS
      LS_COLORS = "$(vivid generate catppuccin-mocha)";
    };

    # TODO: Use overlays on existing packages instead of fetching from gh
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "c85cd0f02844ff2176273a450c955b6532a185dc";
          hash = "sha256-NQjXW/16KLotVGd1/c8MmZ9z455MiC365BQfzDMX3x8=";
        };
        file = "powerlevel10k.zsh-theme";
      }

      {
        name = "powerlevel10k-config";
        src = ./.;
        file = "p10k.zsh";
      }

      {
        name = "vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "cd730cd347dcc0d8ce1697f67714a90f07da26ed";
          hash = "sha256-UQo9shimLaLp68U3EcsjcxokJHOTGhOjDw4XDx6ggF4=";
        };
        file = "zsh-vi-mode.plugin.zsh";
      }

      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
          hash = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }

      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "6aced3f35def61c5edf9d790e945e8bb4fe7b305";
          hash = "sha256-EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
        };
      }

      {
        name = "fzf-tab-source";
        src = pkgs.fetchFromGitHub {
          owner = "Freed-Wu";
          repo = "fzf-tab-source";
          rev = "aabde06d1e82b839a350a8a1f5f5df3d069748fc";
          hash = "sha256-AJrbr2l2tRt42n9ZUmmGaDm10ydwm3fRDlXYI0LoXY0=";
        };
      }
    ];

    profileExtra = ''
      # Source homebrew environment
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Wezterm shell integration
      if [[ "$TERM" == "wezterm" && -f "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh" ]]; then
        source "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh"
      fi

      # Remove ESC delay
      KEYTIMEOUT=1

      # zsh-vi-mode settings
      zvm_config() {
        # ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL

        ZVM_VI_HIGHLIGHT_BACKGROUND=#cba6f7
        ZVM_VI_HIGHLIGHT_FOREGROUND=#181825

        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
        ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK

        local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
        local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
        local vcur=$(zvm_cursor_style $ZVM_VISUAL_MODE_CURSOR)
        local vlcur=$(zvm_cursor_style $ZVM_VISUAL_LINE_MODE_CURSOR)
        local opcur=$(zvm_cursor_style $ZVM_OPPEND_MODE_CURSOR)

        # Append your custom color for your cursor
        ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#89b4fa\a'
        ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#a6e3a1\a'
        ZVM_VISUAL_MODE_CURSOR=$vcur'\e\e]12;#cba6f7\a'
        ZVM_VISUAL_LINE_MODE_CURSOR=$vlcur'\e\e]12;#cba6f7\a'
        ZVM_OPPEND_MODE_CURSOR=$opcur'\e\e]12;#f38ba8\a'

        # Custom functions
        local __term_exit() {
          exit
        }

        # Custom widgets
        zvm_define_widget term_exit __term_exit

        # Custom keybindings
        zvm_bindkey vicmd 'q' term_exit
      }
    '';

    initExtra = ''
      # Wezterm shell completion
      if [[ $(command -v wezterm) != "" ]]; then
        eval "$(wezterm shell-completion --shell zsh)"
      fi

      # zsh-autosuggestions
      bindkey '^y' autosuggest-accept
      # Fix https://github.com/romkatv/powerlevel10k/issues/1554
      unset ZSH_AUTOSUGGEST_USE_ASYNC

      # FZF configuration (fn to guard var scope)
      function {
        local __fzf_preview_eza_args='eza --tree --level=2 --color=always --icons=auto --classify=auto --group-directories-first --header --time-style=long-iso'
        export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/fzf.conf"
        export FZF_COMPLETION_DIR_OPTS="--preview='$__fzf_preview_eza_args {}'"
        export FZF_CTRL_R_OPTS="--no-preview --layout=reverse"
        export FZF_ALT_C_OPTS="$FZF_COMPLETION_DIR_OPTS"

        # fzf-tab
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no
        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview "$__fzf_preview_eza_args \$realpath"
        zstyle ':fzf-tab:complete:z:*' fzf-preview "$__fzf_preview_eza_args \$realpath"
        zstyle ':fzf-tab:complete:zoxide:*' fzf-preview "$__fzf_preview_eza_args \$realpath"
        # switch group using `<` and `>`
        zstyle ':fzf-tab:*' switch-group '<' '>'
        # custom fzf flags
        # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
        zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
        # To make fzf-tab follow FZF_DEFAULT_OPTS.
        # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        enable-fzf-tab
      }

      # Autoload python venv
      python_venv() {
        local __dir_venv=./.venv
        if [[ -d $__dir_venv ]]; then
          # when you cd into a folder that contains $__dir_venv
          source $__dir_venv/bin/activate > /dev/null 2>&1
        else
          # when you cd into a folder that doesn't
          deactivate > /dev/null 2>&1
        fi
      }
      autoload -U add-zsh-hook
      add-zsh-hook chpwd python_venv
      python_venv
    '';
  };
}
