{
  description = "minusfive's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # https://github.com/LnL7/nix-darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/zhaofengli/nix-homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      ...
    }@inputs:
    let
      mkSystem = import ./nix/lib/mkSystem.nix { inherit nixpkgs inputs; };
    in
    {
      darwinConfigurations = {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#mac
        mac = mkSystem {
          system = "aarch64-darwin";
          user = "minusfive";
        };
      };
    };
}
