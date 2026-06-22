[[ -n $BREW_PREFIX ]] && __eval_cached brewenv "$BREW_PREFIX/bin/brew" shellenv

__load instant-prompt
__load exports
__load omz
__load history
__load completions
__load tools
__load aliases

[ -d "$HOME/.local/bin" ] && __add_to_path "$HOME/.local/bin"
[ -d "$HOME/bin" ] && __add_to_path "$HOME/bin"

__cleanup
