HISTSIZE='50000'
HISTFILE="$HOME/.zsh_history"
SAVEHIST="$HISTSIZE"

setopt appendhistory sharehistory hist_save_no_dups hist_find_no_dups \
  hist_ignore_space hist_ignore_all_dups globdots

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[OB" history-beginning-search-forward-end
