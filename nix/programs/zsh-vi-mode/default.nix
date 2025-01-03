{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    # TODO: Use overlays on existing packages instead of fetching from gh
    programs.zsh.plugins = [
      {
        name = "vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "cd730cd347dcc0d8ce1697f67714a90f07da26ed";
          hash = "sha256-UQo9shimLaLp68U3EcsjcxokJHOTGhOjDw4XDx6ggF4=";
        };
        file = "zsh-vi-mode.plugin.zsh";
      }
    ];

    programs.zsh.initExtraFirst = builtins.readFile ./config.zsh;
  };
}
