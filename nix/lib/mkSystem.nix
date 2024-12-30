# This function creates a NixOS system configuration for a particular architecture.
# Inspired by https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
{
  inputs,
  nixpkgs,
  ...
}:

{
  system,
  user,
}:

let
  # Check whether the system is darwin
  isDarwin = nixpkgs.lib.strings.hasSuffix "-darwin" system;

  # The config files for this system
  systemConfig = ../systems/${system}.nix;
  userOSConfig = ../users/${user}--${system}.nix;

  # NixOS vs. nix-darwin functions
  systemFunc = if isDarwin then inputs.nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
in
systemFunc {
  inherit system;

  modules = [
    # Default config for all systems
    {
      # Enable flakes
      nix.settings.experimental-features = "nix-command flakes";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    }

    # System configuration(s)
    systemConfig
    # machineConfig
    userOSConfig

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        inherit inputs isDarwin;
      };
    }
  ];
}
