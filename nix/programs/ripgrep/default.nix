{ user, ... }:
{
  home-manager.users.${user} = {
    programs.ripgrep.enable = true;

    programs.zsh = {
      zsh-abbr.abbreviations = {
        # Cleanup ripgrep output for piping
        rgc = "rg --color=never --no-heading --no-line-number --no-filename";
      };

      sessionVariables = {
        # ripgrep config
        RIPGREP_CONFIG_PATH = "$XDG_CONFIG_HOME/ripgrep/.ripgreprc";
      };
    };
  };
}
