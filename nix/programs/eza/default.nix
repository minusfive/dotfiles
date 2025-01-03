{ user, ... }:
let
  eza_fzf_cmd = "eza --tree --level=2 --color=always --icons=auto --classify=auto --group-directories-first --header --time-style=long-iso";
in
{
  home-manager.users.${user} = {
    programs.eza.enable = true;

    home.shellAliases = {
      # Use `eza` instead of `ls` with some default options
      ls = "eza --color=auto --icons=auto --classify=auto --group-directories-first --header --time-style=long-iso";
      # Same as above + show all files except "." & ".."
      la = "ls --all";
      # Same as above + long list + use powers of 1000 vs. 1024 + ISO time
      ll = "la --long";
      # Same as above + sort by modification time
      lm = "ll --modified --sort=modified";
      # Same as 'll' above + output as a tree
      lt = "ll --tree --level=2 ";
    };

    programs.zsh.initExtra = ''
      # FZF: preview directories contents with eza when completing cd and zoxide
      zstyle ':fzf-tab:complete:cd:*' fzf-preview "${eza_fzf_cmd} \$realpath"
      zstyle ':fzf-tab:complete:z:*' fzf-preview "${eza_fzf_cmd} \$realpath"
      zstyle ':fzf-tab:complete:zoxide:*' fzf-preview "${eza_fzf_cmd} \$realpath"
    '';
  };
}
