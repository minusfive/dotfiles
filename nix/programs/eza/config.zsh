# wrapped in immediately executed anonymous function to contain var scope
function {
  # Eza + Fzf: preview directories contents with eza when completing cd and zoxide
  local __eza_fzf_cmd='eza --tree --level=2 --color=always --icons=auto --classify=auto --group-directories-first --header --time-style=long-iso';
  export FZF_COMPLETION_DIR_OPTS="--preview='$__eza_fzf_cmd {}'"
  zstyle ':fzf-tab:complete:cd:*' fzf-preview "$__eza_fzf_cmd \$realpath"
  zstyle ':fzf-tab:complete:z:*' fzf-preview "$__eza_fzf_cmd \$realpath"
  zstyle ':fzf-tab:complete:zoxide:*' fzf-preview "$__eza_fzf_cmd \$realpath"
}
