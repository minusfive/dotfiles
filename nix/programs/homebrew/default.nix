{
  inputs,
  user,
  config,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  config = {
    environment.variables = {
      HOMEBREW_NO_ANALYTICS = "1";
    };

    # Homebrew
    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        extraFlags = [ "--verbose" ];
        upgrade = true;
      };

      taps = builtins.attrNames config.nix-homebrew.taps;
    };

    home-manager.users.${user} = {
      programs.zsh.profileExtra = builtins.readFile ./config.zsh;
    };

    nix-homebrew = {
      # User owning the Homebrew prefix
      inherit user;

      # Install Homebrew under the default prefix
      enable = true;

      # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
      # enableRosetta = true;

      # Optional: Declarative tap management
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
        "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      };

      # Automatically migrate existing Homebrew installations
      autoMigrate = true;

      # Optional: Enable fully-declarative tap management
      #
      # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
      mutableTaps = false;
    };
  };
}
