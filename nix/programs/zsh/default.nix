{ pkgs, user, ... }:
{
  environment.shells = [ pkgs.zsh ];

  home-manager.users.${user} = {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autocd = true;

      history = {
        expireDuplicatesFirst = true;
      };

      # These are similar to aliases, but they expand the command on submission
      # so the full command is retained in history and is more shareable
      zsh-abbr = {
        enable = true;
        abbreviations = {
          # Terminal control
          q = "exit";
          c = "clear";

          # SSH
          # alias ssh="ssh -X"

          # Keep bunzip2 decompressed files
          bunzip2 = "bunzip2 -k";
        };
      };

      localVariables = {
        # Remove ESC delay
        KEYTIMEOUT = "1";
      };

      sessionVariables = {
        # Multiplexers
        ZELLIJ_CONFIG_DIR = "$XDG_CONFIG_HOME/zellij";
      };
    };
  };
}
