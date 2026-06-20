zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

if command -v fzf >/dev/null 2>&1; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  __eval_cached fzf fzf --zsh

  if command -v zoxide >/dev/null 2>&1; then
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    __eval_cached zoxide zoxide init --cmd cd zsh
  fi
fi
