final: prev: {
  zsh-fast-syntax-highlighting = prev.zsh-fast-syntax-highlighting.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "zdharma-continuum";
      repo = "fast-syntax-highlighting";
      rev = "master";
      hash = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
    };
  });
}
