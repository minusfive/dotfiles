{
  homebrew.casks = [ "hammerspoon" ];

  # Use $XDG_CONFIG_HOME instead of default ~/.hammerspoon
  system.defaults.CustomUserPreferences."org.hammerspoon.Hammerspoon" = {
    MJConfigFile = "~/.config/hammerspoon/init.lua";
  };
}
