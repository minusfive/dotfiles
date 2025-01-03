{ user, ... }:
{
  environment.variables = {
    TERMINFO_DIRS = [ "$HOME/.config/wezterm/terminfo" ];
  };

  homebrew.casks = [ "wezterm@nightly" ];

  home-manager.users.${user} = {
    home.shellAliases = {
      t = "wezterm cli set-tab-title";
      wt = "wezterm cli set-window-title";
    };

    programs.zsh.initExtraFirst = ''
      # Wezterm shell integration
      if [[ "$TERM" == "wezterm" && -f "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh" ]]; then
        source "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh"
      fi
    '';

    programs.zsh.initExtra = ''
      # Wezterm shell completion
      if [[ $(command -v wezterm) != "" ]]; then
        eval "$(wezterm shell-completion --shell zsh)"
      fi
    '';
  };
}
