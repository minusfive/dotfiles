{ user, ... }:
{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;
      diff-highlight.enable = true;
    };
  };
}
