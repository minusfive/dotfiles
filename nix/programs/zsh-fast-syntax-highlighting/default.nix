{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.zsh.plugins = [
      {
        name = pkgs.zsh-fast-syntax-highlighting.pname;
        src = pkgs.zsh-fast-syntax-highlighting.src;
        file = "fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };
}
