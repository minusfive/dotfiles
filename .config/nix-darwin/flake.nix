{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/zhaofengli/nix-homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.nixfmt-rfc-style
          ];

          environment.variables = {
            TERMINFO_DIRS = [ "$HOME/.config/wezterm/terminfo" ];
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

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
              "com.apple.trackpad.scaling" = 1.0;
            };

            # TODO: screencapture
            # TODO: screensaver
          };

          # Homebrew
          homebrew = {
            enable = true;

            onActivation = {
              autoUpdate = true;
              cleanup = "zap";
              upgrade = true;
              extraFlags = [
                "--verbose"
              ];
            };

            # TODO: Check whether brew-cask-upgrade is needed and can run
            # taps = [ "buo/cask-upgrade" ];

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
              "hammerspoon" # macOS automation
              "wezterm@nightly" # Terminal emulator
              "obsidian" # Note-taking
              "betterdisplay" # Display configuration manager
              "imageoptim" # Image optimizer
              "discord" # Chat app
              "gpg-suite" # GPG keychain
              "google-chrome"
            ];

            masApps = {
              "WhatsApp Messenger" = 310633997;
              "1Password for Safari" = 1569813296;
            };

          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macos
      darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            # Homebrew
            nix-homebrew = {
              enable = true;
              user = "minusfive";
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
