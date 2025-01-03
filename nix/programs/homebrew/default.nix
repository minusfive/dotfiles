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
  };

  home-manager.users.${user} = {
    programs.zsh.profileExtra = builtins.readFile ./config.zsh;
  };
}
