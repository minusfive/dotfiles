{ pkgs, user, ... }:
{
  homebrew = {
    brews = [
      "podman"
      # "podman-tui"
    ];

    casks = [
      "podman-desktop"
    ];
  };

  home-manager.users.${user} = {
    home.packages = [
      # pkgs.podman
      pkgs.podman-tui
    ];
  };
}
