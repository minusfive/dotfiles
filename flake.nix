{
  description = "minusfive's system(s) config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
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
