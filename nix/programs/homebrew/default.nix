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
      "betterdisplay" # Display configuration manager
      "discord" # Chat app
      "ghostty" # Terminal emulator
      "google-chrome"
      "gpg-suite" # GPG keychain
      "imageoptim" # Image optimizer
      "obsidian" # Note-taking
    ];
  };

  home-manager.users.${user} = {
    programs.zsh.profileExtra = ''
      # Source homebrew environment
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
