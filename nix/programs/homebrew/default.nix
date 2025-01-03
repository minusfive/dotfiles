{ user, ... }:
{
  environment.variables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_AUTO_UPDATE = "1";
  };

  # Homebrew
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--verbose" ];
      upgrade = true;
    };

    casks = [
      "1password" # Password manager
      "betterdisplay" # Display configuration manager
      "discord" # Chat app
      "ghostty" # Terminal emulator
      "google-chrome"
      "gpg-suite" # GPG keychain
      "imageoptim" # Image optimizer
      "obsidian" # Note-taking
    ];

    masApps = {
      "WhatsApp Messenger" = 310633997;
      "1Password for Safari" = 1569813296;
    };
  };

  home-manager.users.${user} = {
    programs.zsh.profileExtra = ''
      # Source homebrew environment
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
