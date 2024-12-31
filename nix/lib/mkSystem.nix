# This function creates a NixOS system configuration for a particular architecture.
# Inspired by https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
{
  inputs,
  ...
}:

{
  user,
  system ? "aarch64-darwin",
}:

let
  lib = inputs.nixpkgs.lib;
  isDarwin = lib.strings.hasSuffix "darwin" system;
  nix-darwin = inputs.nix-darwin;
  home-manager = inputs.home-manager;
  systemFn = if isDarwin then nix-darwin.lib.darwinSystem else lib.nixosSystem;
  hmModules = if isDarwin then home-manager.darwinModules else home-manager.nixosModules;
in
systemFn {
  inherit system;

  specialArgs = { inherit inputs user; };

  modules = [
    # Default config for all systems
    {
      # Enable flakes
      nix.settings.experimental-features = "nix-command flakes";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Install all packages docs
      nixpkgs.config.documentation.enable = true;
      nixpkgs.config.documentation.man.enable = true;
      nixpkgs.config.documentation.dev.enable = true;
    }

    # System configuration
    ../systems/${system}.nix

    # User configruation
    ../users/${user}/${system}.nix
    hmModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs user; };
      home-manager.users.${user} = import ../users/${user}/home.nix;
    }
  ];
}
