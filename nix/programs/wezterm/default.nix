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

    programs.zsh.initExtraFirst = builtins.readFile ./shell-integration.zsh;

    programs.zsh.initExtra = builtins.readFile ./shell-completion.zsh;
  };
}
