export HOMEBREW_NO_ANALYTICS=1

export EDITOR='vim'
export VISUAL="$EDITOR"
export PAGER='less'
export LESS='-R'
export MANPAGER='less -R'
command -v bat >/dev/null 2>&1 && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export LANG='en_US.UTF-8'
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;40:cd=1;33;40:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:mi=0;41:or=0;41'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

if command -v gpgconf >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent
fi

setopt auto_cd auto_pushd pushd_ignore_dups pushd_silent interactive_comments extended_glob no_beep
