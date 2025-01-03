{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    home.sessionVariables.EDITOR = "nvim";

    # Apps we want installed
    home.packages = with pkgs; [
      neovim-node-client
      nixd
      nixfmt-rfc-style
      nodejs_23 # Required by some LSPs and Copilot
      ruby
      rustup # Required for some plugins development
    ];

    programs.neovim.enable = true; # Preferred text editor

    programs.zsh.zsh-abbr.abbreviations = {
      v = "nvim";
    };
  };
}
