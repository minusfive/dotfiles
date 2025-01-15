{
  description = "minusfive's system(s) config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Hhome-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.inputs.nix-darwin.follows = "nix-darwin";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      mkSystem = import ./nix/lib/mkSystem.nix { inherit inputs; };
    in
    {
      darwinConfigurations = {
        # Build with: `$ darwin-rebuild build --flake .#personal`
        personal = mkSystem {
          user = "minusfive";
          system = "aarch64-darwin";
        };

        # Build with: `$ darwin-rebuild build --flake .#work`
        # work = mkSystem { user = ""; system = ""; };
      };
    };
}
