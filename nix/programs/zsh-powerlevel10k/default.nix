{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.zsh.plugins = [
      {
        name = pkgs.zsh-powerlevel10k.pname;
        src = pkgs.zsh-powerlevel10k.src;
        file = "powerlevel10k.zsh-theme";
      }

      {
        name = "powerlevel10k-config";
        src = ./.;
        file = "config.zsh";
      }
    ];

    programs.zsh.initExtraFirst = builtins.readFile ./instant-prompt.zsh;
  };
}
