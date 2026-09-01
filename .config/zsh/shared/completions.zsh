zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"

if (( $+commands[eza] )); then
  __ls_preview='eza -1 --color=always $realpath'
else
  __ls_preview='ls --color $realpath'
fi

if (( $+commands[fzf] )); then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview "$__ls_preview"
  __eval_cached fzf fzf --zsh
  bindkey "^O" fzf-cd-widget

  if (( $+commands[zoxide] )); then
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "$__ls_preview"
    __eval_cached zoxide zoxide init --cmd cd zsh
  fi
fi
unset __ls_preview
