{
  description = "minusfive's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      mkSystem = import ./nix/lib/mkSystem.nix { inherit inputs; };
    in
    {
      darwinConfigurations = {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#personal
        personal = mkSystem {
          user = "minusfive";
          system = "aarch64-darwin";
        };
        # work = mkSystem { user = ""; system = ""; };
      };
    };
}
