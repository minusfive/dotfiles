{ pkgs, user, ... }:
let
  programs = [
    "bat"
    "eza"
    "fzf"
    "gnu-coreutils"
    "gnu-stow"
    "hammerspoon"
    "homebrew"
    "lazygit"
    "neovim"
    "oh-my-zsh"
    "ripgrep"
    "vivid"
    "wezterm"
    "yazi"
    "zsh"
    "zsh-autosuggestions"
    "zsh-fast-syntax-highlighting"
    "zsh-powerlevel10k"
    "zsh-vi-mode"
  ];
in
{
  imports = map (program: ../../programs/${program}) programs;

  config = {
    users.users.${user} = {
      name = user;
      home = /Users/${user};
    };

    # Use Touch ID for sudo authentication. (e.g. Apple Watch)
    security.pam.enableSudoTouchIdAuth = true;

    # System Settings
    system.defaults = {
      # TODO: screencapture
      # TODO: screensaver
      # TODO: screen corners

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

    home-manager.users.${user} = {
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.11";

      # Use standard XDG directories
      xdg.enable = true;
      home.preferXdgDirectories = true;

      home.sessionVariables = {
        # Disable Next.js telemetry https://nextjs.org/telemetry
        NEXT_TELEMETRY_DISABLED = 1;
      };

      # Apps we want installed
      home.packages = with pkgs; [
        gum
        wget
      ];

      # TODO: Manage catppuccin theme installation for all tools
      programs.fd.enable = true; # `find` replacement
      programs.go.enable = true; # Go programming language
      programs.htop.enable = true; # `top` replacement
      programs.jq.enable = true; # JSON processor
      programs.zoxide.enable = true; # `cd` replacement

      programs.git = {
        enable = true;
        diff-highlight.enable = true;
      };
    };
  };
}
