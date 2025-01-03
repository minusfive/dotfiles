final: prev: {
  zsh-powerlevel10k = prev.zsh-powerlevel10k.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "romkatv";
      repo = prev.zsh-powerlevel10k.pname;
      rev = "master";
      hash = "sha256-NQjXW/16KLotVGd1/c8MmZ9z455MiC365BQfzDMX3x8=";
    };
  });
}
