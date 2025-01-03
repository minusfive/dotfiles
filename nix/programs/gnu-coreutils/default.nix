{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    home.packages = [ pkgs.coreutils ];
    home.shellAliases = {
      # Make coreutils safer
      rm = "rm --preserve-root -iv";
      ln = "ln -iv";
      mv = "mv -iv";
      cp = "cp -iv";
    };
  };
}
