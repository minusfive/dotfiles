{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    # TODO: Use overlays on existing packages instead of fetching from gh
    programs.zsh.plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "c85cd0f02844ff2176273a450c955b6532a185dc";
          hash = "sha256-NQjXW/16KLotVGd1/c8MmZ9z455MiC365BQfzDMX3x8=";
        };
        file = "powerlevel10k.zsh-theme";
      }

      {
        name = "powerlevel10k-config";
        src = ./.;
        file = "p10k.zsh";
      }

    ];

    programs.zsh.initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
  };
}
