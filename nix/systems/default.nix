# Default config for all systems
{
  inputs,
  user,
  lib,
  ...
}:
{
  # Enable flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add overlays
  nixpkgs.overlays = map (o: import o) (lib.filesystem.listFilesRecursive ../overlays);

  # Install all packages docs
  nixpkgs.config.documentation.enable = true;
  nixpkgs.config.documentation.man.enable = true;
  nixpkgs.config.documentation.dev.enable = true;

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs user; };

  # Environment Variables
  environment.variables = {
    # Disable Next.js telemetry https://nextjs.org/telemetry
    NEXT_TELEMETRY_DISABLED = "1";
  };
}
