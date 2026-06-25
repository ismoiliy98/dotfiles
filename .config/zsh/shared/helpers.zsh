__load() { source "$ZDOTDIR/shared/$1.zsh"; }

__add_to_path() { path=("$1" $path); }

__eval_cached() {
  local name="$1"; shift
  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/${name}.zsh"
  local bin="$1"; [[ $bin == */* ]] || bin="$commands[$bin]"
  if [[ ! -r "$cache" || "$bin" -nt "$cache" ]]; then
    mkdir -p "${cache:h}"
    "$@" > "$cache" 2>/dev/null
  fi
  source "$cache"
}

__cleanup() {
  unfunction __load __add_to_path __eval_cached
  unset -f __cleanup
}
