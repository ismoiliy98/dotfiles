zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

if (( $+commands[fzf] )); then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  __eval_cached fzf fzf --zsh

  if (( $+commands[zoxide] )); then
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    __eval_cached zoxide zoxide init --cmd cd zsh
  fi
fi
