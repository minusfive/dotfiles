{ user, ... }:
let
  # CLI tools managed by Nix; GUI macOS apps managed by Homebrew
  programs = [
    "1password" # password maanger
    "bat" # better `cd`
    "bash" # shell
    "betterdisplay" # display configuration manager
    "direnv" # per-directory shell environment
    "discord" # chat app
    "docker" # container engine
    "eza" # better `ls`
    "fd" # better `find`
    "fzf" # fuzzy-finder
    "ghostty" # terminal emulator
    "git" # version control
    "gnu-coreutils" # standard core unix utils (e.g. `rm`, `ln`, `mv`, etc.)
    "gnu-stow" # symlink manager
    "gnu-wget" # "web get", i.e. file retriever
    "go" # Go programming language
    "google-chrome" # browser
    "gpg-suite" # GPG keychain
    "gum" # Go TUI builder
    "hammerspoon" # macOS automation
    "homebrew" # macOS package manager
    "htop" # better `top`
    "imageoptim" # image optimizer
    "jq" # json query and manipulation utility
    "lazygit" # git TUI
    "lima" # vm manager
    "neovim" # editor
    "obsidian" # note-taking
    "oh-my-zsh" # zsh configuration manager
    "podman" # daemonless container engine
    "ripgrep" # better `grep`
    "vivid" # LS_COLORS generator
    "wezterm" # terminal emulator
    "whatsapp" # chat app
    "yazi" # TUI file manager
    "zoom" # video conferencing
    "zoxide" # better `cd`
    "zsh" # shell
    "zsh-autosuggestions" # zsh autocomplete hints
    "zsh-fast-syntax-highlighting" # zsh syntax highlighter
    "zsh-powerlevel10k" # zsh promt customizatin framework
    "zsh-vi-mode" # VIM motions on shell
  ];
in
{
  imports = map (program: ../../programs/${program}) programs;

  config = {
    users.users.${user} = {
      name = user;
      home = /Users/${user};
    };

    home-manager.users.${user} = {
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.11";

      # Use standard XDG directories
      xdg.enable = true;
      home.preferXdgDirectories = true;
    };

    # Use Touch ID for sudo authentication. (e.g. Apple Watch)
    security.pam.enableSudoTouchIdAuth = true;

    # System Settings
    system.defaults = {
      # TODO: screencapture
      # TODO: screensaver
      # TODO: screen corners
      # TODO: Manage catppuccin theme installation for all tools

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
    };
  };
}
