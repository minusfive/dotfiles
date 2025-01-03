{ user, ... }:
{
  home-manager.users.${user} = {
    programs.jq.enable = true;
  };
}
