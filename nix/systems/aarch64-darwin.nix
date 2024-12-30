{ inputs, pkgs, ... }:

{
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # A list of permissible login shells for user accounts.
  # The default macOS shells will be automatically included:
  # - /bin/bash
  # - /bin/csh
  # - /bin/dash
  # - /bin/ksh
  # - /bin/sh
  # - /bin/tcsh
  # - /bin/zsh
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];
}
