HISTSIZE='100000'
SAVEHIST="$HISTSIZE"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"
[[ ! -s $HISTFILE && -s $HOME/.zsh_history ]] && cp "$HOME/.zsh_history" "$HISTFILE"

setopt no_bang_hist appendhistory sharehistory hist_save_no_dups hist_find_no_dups \
  hist_ignore_space hist_ignore_all_dups hist_expire_dups_first \
  hist_reduce_blanks hist_verify

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[OB" history-beginning-search-forward-end
