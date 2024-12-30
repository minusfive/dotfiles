{ pkgs, ... }:
{
  environment.variables = {
    TERMINFO_DIRS = [ "$HOME/.config/wezterm/terminfo" ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Use Touch ID for sudo authentication. (e.g. Apple Watch)
  security.pam.enableSudoTouchIdAuth = true;

  # System Settings
  system.defaults = {
    controlcenter = {
      Bluetooth = true;
    };

    dock = {
      autohide = true;
      expose-group-apps = true;
      persistent-apps = [ ];
      persistent-others = [ ];
      show-recents = true;
      static-only = true;
    };

    finder = {
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "clmv";
      FXRemoveOldTrashItems = true;
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = true;
      ShowStatusBar = true;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0;
    };

    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      "com.apple.trackpad.scaling" = 5.0;
    };

    CustomUserPreferences = {
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = "~/.config/hammerspoon/init.lua";
      };
    };

    # TODO: screencapture
    # TODO: screensaver
  };

  # Homebrew
  homebrew = {
    brews = [
      "bat" # `cat` replacement
      "coreutils" # GNU core utilities
      "eza" # `ls` replacement
      "fd" # `find` replacement
      "fzf" # Fuzzy finder
      "git"
      "go"
      "gum" # Go based interactive shell script generator
      "htop" # `top` replacement
      "jq" # JSON processor
      "lazygit" # Git Terminal UI
      "neovim" # Preferred text editor
      "node"
      "pipx" # Python apps installer
      "ripgrep" # `grep` replacement
      "ruby"
      "stow" # Symlink manager
      "vivid" # `LS_COLORS` generator
      "wget"
      "yazi" # File manager in terminal
      "zoxide" # `cd` replacement
      "zsh"

      {
        name = "rustup";
        link = true;
      }
    ];

    casks = [
      "1password" # Password manager
      "betterdisplay" # Display configuration manager
      "discord" # Chat app
      "ghostty" # Terminal emulator
      "google-chrome"
      "gpg-suite" # GPG keychain
      "hammerspoon" # macOS automation
      "imageoptim" # Image optimizer
      "obsidian" # Note-taking
      "wezterm@nightly" # Terminal emulator
    ];

    masApps = {
      "WhatsApp Messenger" = 310633997;
      "1Password for Safari" = 1569813296;
    };
  };
}
