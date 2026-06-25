__load instant-prompt

if [[ -n $BREW_PREFIX ]]; then
  __eval_cached brewenv "$BREW_PREFIX/bin/brew" shellenv
  path=("$BREW_PREFIX"/{bin,sbin} $path)
fi
__load exports
__load antidote
__load history
__load completions
__load tools
__load aliases

[[ -d "$HOME/.local/bin" ]] && __add_to_path "$HOME/.local/bin"
[[ -d "$HOME/bin" ]] && __add_to_path "$HOME/bin"

__cleanup
