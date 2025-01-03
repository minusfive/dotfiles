{ user, ... }:
{
  home-manager.users.${user} = {
    programs.bat.enable = true;
    home.shellAliases = {
      cat = "bat";
    };
  };
}
