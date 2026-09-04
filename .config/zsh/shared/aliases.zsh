alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
  alias l='eza -la --group-directories-first --git'
  alias ll='eza -l --group-directories-first --git'
  alias la='l'
  alias lt='eza --tree --level=2 --group-directories-first'
else
  alias ls='ls --color'
  alias l='ls -lhA'
  alias ll='ls -l'
  alias la='l'
fi

(( $+commands[rg] )) && alias grep='rg'
(( $+commands[fd] )) && alias find-name='fd'

alias pip='python3 -m pip'
alias pip3='python3 -m pip'

alias c='clear'
alias reload='exec zsh'
alias path='print -l $path'
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }

alias brewup='brew update && brew upgrade && brew cleanup'

alias expo-doctor='bunx expo-doctor'

frpc() {
  if [[ -z "$1" ]]; then
    ~/frp/frpc -c ~/frp/frpc.toml
    return
  fi
  local config=~/frp/${1}.toml
  if [[ ! -f "$config" ]]; then
    echo "error: config not found: $config" >&2
    return 1
  fi
  ~/frp/frpc -c "$config"
}
