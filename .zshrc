# Load helper functions
source "$HOME/.config/zsh/.helpers.zsh"

# Homebrew (needs to be loaded ASAP, because some configs may use casks)
if [ "$(uname -s)" = "Darwin" ]; then
  __add_to_path '/opt/homebrew/bin'
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(brew shellenv)"
fi

# Load configs
__load 'instant-prompt'
__load 'oh-my'
__load 'history-settings'
__load 'completions'
__load 'aliases'

# If came from bash
__add_to_path "$HOME/bin"
__add_to_path "$HOME/.local/bin"
__add_to_path "/usr/local/bin"

# GPG
command -v gpgconf >/dev/null 2>&1 && export GPG_TTY=$(tty) &&
  gpgconf --launch gpg-agent

# NVM
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# PNPM
case "$(uname -s)" in
"Darwin") export PNPM_HOME="$HOME/Library/pnpm" ;;
"Linux") export PNPM_HOME="$HOME/.local/share/pnpm" ;;
esac

[ -d "$PNPM_HOME" ] && __add_to_path "$PNPM_HOME" || unset PNPM_HOME

# Bun
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
  __add_to_path "$BUN_INSTALL/bin"
fi

# Golang
if [ -d "$HOME/go/bin" ]; then
  export GOPATH="$HOME/go"
elif [ -d "/usr/local/go/bin" ]; then
  export GOPATH="$HOME/usr/local/go"
fi
[ -n "$GOPATH" ] && __add_to_path "$GOPATH/bin"

# Deno
if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  __add_to_path "$DENO_INSTALL/bin"
fi

# Android
if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
fi
[ -n "$ANDROID_HOME" ] &&
  __add_to_path "$ANDROID_HOME/tools" &&
  __add_to_path "$ANDROID_HOME/platform-tools"

# Turso
[ -d "$HOME/.turso" ] && __add_to_path "$HOME/.turso"

# Cleanup
__cleanup
