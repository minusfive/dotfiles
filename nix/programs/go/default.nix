# Go programming language
{ user, ... }:
{
  home-manager.users.${user} = {
    programs.go.enable = true;
  };
}
