alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ls='ls --color'
alias l='ls -lhA'
alias ll='ls -l'
alias la='l'

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
