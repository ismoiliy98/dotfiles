# Helper functions
__load() {
  source "$HOME/.config/zsh/.$1.zsh"
}
__add_to_path() {
  case ":$PATH:" in
  *":$1:"*) ;;
  *) export PATH="$1:$PATH" ;;
  esac
}

# Homebrew
if [ "$(uname -s)" = "Darwin" ]; then
  __add_to_path '/opt/homebrew/bin'
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(brew shellenv)"
fi

# Load configs
__load 'instant-prompt'
__load 'zinit'
__load 'p10k-prompt'
__load 'zinit-plugins'
__load 'history-settings'
__load 'completions'
__load 'smart-mover'
__load 'aliases'

# GPG
command -v gpgconf >/dev/null 2>&1 && export GPG_TTY=$(tty) && gpgconf --launch gpg-agent

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

# Go
if [ -d "$HOME/go/bin" ]; then
  export GOPATH="$HOME/go"
elif [ -d "/usr/local/go/bin" ]; then
  export GOPATH="$HOME/usr/local/go"
fi
[ -n "$GOPATH" ] && __add_to_path "$GOPATH/bin"

# Autocd
setopt auto_cd

# Cleanup
unfunction __load __add_to_path
