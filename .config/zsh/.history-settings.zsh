HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_save_no_dups hist_find_no_dups hist_ignore_space hist_ignore_dups hist_ignore_all_dups globdots
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
autoload -U history-search-end
autoload -Uz compinit && compinit
zinit cdreplay -q
