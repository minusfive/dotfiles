{ user, ... }:
{
  home-manager.users.${user} = {
    programs.lazygit.enable = true;

    programs.zsh.sessionVariables = {
      # Lazygit
      LG_CONFIG_FILE = "$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml";
    };

    programs.zsh.zsh-abbr.abbreviations = {
      lg = "lazygit";
    };
  };
}
