[ -d "$HOME/.bun/bin" ] && __add_to_path "$HOME/.bun/bin"

if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  __add_to_path "$GOPATH/bin"
fi

[ -d "$HOME/.cargo/bin" ] && __add_to_path "$HOME/.cargo/bin"

if [ -d "$HOME/.deno/bin" ]; then
  export DENO_INSTALL="$HOME/.deno"
  __add_to_path "$DENO_INSTALL/bin"
fi

[ -d "$HOME/.turso" ] && __add_to_path "$HOME/.turso"

if [ -n "$ANDROID_HOME" ]; then
  for _d in platform-tools cmdline-tools/latest/bin emulator; do
    [ -d "$ANDROID_HOME/$_d" ] && __add_to_path "$ANDROID_HOME/$_d"
  done
  unset _d
fi

[ -d "$HOME/.lmstudio/bin" ] && __add_to_path "$HOME/.lmstudio/bin"
