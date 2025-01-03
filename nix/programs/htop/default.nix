{ user, ... }:
{
  home-manager.users.${user} = {
    programs.htop.enable = true;
  };
}
