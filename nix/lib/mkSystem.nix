# This function creates a NixOS system configuration for a particular architecture.
# Inspired by https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
{ inputs, ... }:
{ user, system }:
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

  # Extra arguments passed down to all modules
  specialArgs = { inherit inputs user; };

  modules = [
    # Default config for all systems
    ../systems

    # System configuration
    ../systems/${system}.nix

    # User configuration
    ../users/${user}/${system}.nix

    # Home Manager module
    hmModules.home-manager
  ];
}
