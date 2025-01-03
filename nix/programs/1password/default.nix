{ pkgs, user, ... }:
{
  homebrew = {
    casks = [ "1password" ];
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };

  home-manager.users.${user} = {
    home.packages = [ pkgs._1password-cli ];
  };
}
