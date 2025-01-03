# This function creates a NixOS system configuration for a particular architecture.
# Inspired by https://github.com/mitchellh/nixos-config/blob/main/lib/mksystem.nix
{ inputs, ... }:
{ user, system }:
let
  lib = inputs.nixpkgs.lib;
  isDarwin = lib.strings.hasSuffix "darwin" system;
  nix-darwin = inputs.nix-darwin;
  systemFn = if isDarwin then nix-darwin.lib.darwinSystem else lib.nixosSystem;
in
systemFn {
  inherit system;

  # Extra arguments passed down to all modules
  specialArgs = { inherit inputs user; };

  modules = [
    # System configuration
    ../systems/${system}.nix

    # User configuration
    ../users/${user}/${system}.nix
  ];
}
