{ user, ... }:
{
  home-manager.users.${user} = {
    programs.zsh.autosuggestion.enable = true;
    programs.zsh.initExtra = builtins.readFile ./config.zsh;
  };
}
