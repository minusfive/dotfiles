{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    home.packages = [ pkgs.vivid ];

    programs.zsh.sessionVariables = {
      # Colorize LS
      LS_COLORS = "$(vivid generate catppuccin-mocha)";
    };
  };
}
