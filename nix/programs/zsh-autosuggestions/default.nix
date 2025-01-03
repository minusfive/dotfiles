{ user, ... }:
{
  home-manager.users.${user} = {
    programs.zsh.autosuggestion.enable = true;
    programs.zsh.initExtra = ''
      # zsh-autosuggestions
      bindkey '^y' autosuggest-accept
      # Fix https://github.com/romkatv/powerlevel10k/issues/1554
      unset ZSH_AUTOSUGGEST_USE_ASYNC
    '';
  };
}
