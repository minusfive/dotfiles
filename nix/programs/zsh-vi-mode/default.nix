{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.zsh.plugins = [
      {
        name = pkgs.zsh-vi-mode.pname;
        src = pkgs.zsh-vi-mode.src;
      }
    ];

    programs.zsh.initExtraFirst = builtins.readFile ./config.zsh;
  };
}
