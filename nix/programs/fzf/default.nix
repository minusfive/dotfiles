# Fzf configuration
{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.fzf.enable = true; # Fuzzy finder

    # TODO: Use overlays on existing packages instead of fetching from gh
    programs.zsh.plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "6aced3f35def61c5edf9d790e945e8bb4fe7b305";
          hash = "sha256-EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
        };
      }

      {
        name = "fzf-tab-source";
        src = pkgs.fetchFromGitHub {
          owner = "Freed-Wu";
          repo = "fzf-tab-source";
          rev = "aabde06d1e82b839a350a8a1f5f5df3d069748fc";
          hash = "sha256-AJrbr2l2tRt42n9ZUmmGaDm10ydwm3fRDlXYI0LoXY0=";
        };
      }
    ];

    programs.zsh.oh-my-zsh.plugins = [ "fzf" ];

    programs.zsh.initExtra = builtins.readFile ./config.zsh;
  };
}
