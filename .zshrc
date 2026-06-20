source "$HOME/.config/zsh/.helpers.zsh"

typeset -U path PATH

if [[ $OSTYPE == darwin* && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

__load 'instant-prompt'
__load 'exports'
__load 'oh-my'
__load 'history-settings'
__load 'completions'
__load 'tools'
__load 'aliases'

[ -d "$HOME/.local/bin" ] && __add_to_path "$HOME/.local/bin"
[ -d "$HOME/bin" ] && __add_to_path "$HOME/bin"

__cleanup
