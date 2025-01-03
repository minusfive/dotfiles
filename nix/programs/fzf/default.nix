# Fzf configuration
{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.fzf.enable = true; # Fuzzy finder

    programs.zsh.plugins = [
      {
        name = pkgs.zsh-fzf-tab.pname;
        src = pkgs.zsh-fzf-tab.src;
        file = "fzf-tab.plugin.zsh";
      }

      {
        # TODO: Contribute to nixpkgs
        name = "fzf-tab-source";
        src = pkgs.fetchFromGitHub {
          owner = "Freed-Wu";
          repo = "fzf-tab-source";
          rev = "main";
          hash = "sha256-AJrbr2l2tRt42n9ZUmmGaDm10ydwm3fRDlXYI0LoXY0=";
        };
      }
    ];

    programs.zsh.oh-my-zsh.plugins = [ "fzf" ];

    programs.zsh.initExtra = builtins.readFile ./config.zsh;
  };
}
