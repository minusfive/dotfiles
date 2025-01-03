final: prev: {
  zsh-vi-mode = prev.zsh-vi-mode.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "jeffreytse";
      repo = prev.zsh-vi-mode.pname;
      rev = "master";
      hash = "sha256-UQo9shimLaLp68U3EcsjcxokJHOTGhOjDw4XDx6ggF4=";
    };
  });
}
