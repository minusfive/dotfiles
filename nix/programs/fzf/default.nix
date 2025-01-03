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

    programs.zsh.initExtra = ''
      # FZF configuration (fn to guard var scope)
      export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/fzf.conf"
      export FZF_COMPLETION_DIR_OPTS="--preview='$__fzf_preview_eza_args {}'"
      export FZF_CTRL_R_OPTS="--no-preview --layout=reverse"
      export FZF_ALT_C_OPTS="$FZF_COMPLETION_DIR_OPTS"

      # fzf-tab
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no
      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'
      # custom fzf flags
      # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
      zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
      # To make fzf-tab follow FZF_DEFAULT_OPTS.
      # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      enable-fzf-tab
    '';
  };
}
