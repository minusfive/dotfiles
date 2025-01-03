final: prev: {
  zsh-fzf-tab = prev.zsh-fzf-tab.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "Aloxaf";
      repo = "fzf-tab";
      rev = "master";
      hash = "sha256-EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
    };
  });
}
