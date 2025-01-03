{ user, ... }:
{
  home-manager.users.${user} = {
    programs.fd.enable = true;
  };
}
