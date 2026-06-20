if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  __add_to_path "$BUN_INSTALL/bin"
  [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  __load_nvm() {
    unset -f nvm node npm npx corepack __load_nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  }
  for _cmd in nvm node npm npx corepack; do
    eval "${_cmd}() { __load_nvm; ${_cmd} \"\$@\"; }"
  done
  unset _cmd
fi

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

if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  for _d in platform-tools cmdline-tools/latest/bin emulator; do
    [ -d "$ANDROID_HOME/$_d" ] && __add_to_path "$ANDROID_HOME/$_d"
  done
  unset _d
fi

[ -d "$HOME/.lmstudio/bin" ] && __add_to_path "$HOME/.lmstudio/bin"
