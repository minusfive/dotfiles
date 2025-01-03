{ user, ... }:
{
  home-manager.users.${user} = {
    programs.yazi.enable = true;
    programs.zsh.zsh-abbr.abbreviations = {
      f = "yy";
    };
  };
}
