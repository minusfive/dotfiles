{ pkgs, ... }:
{
  environment.shells = [ pkgs.bashInteractive ];
}
