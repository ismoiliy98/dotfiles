ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
typeset -U path PATH

case "$OSTYPE" in
  darwin*) DOTFILES_OS=macos ;;
  linux*)  DOTFILES_OS=linux ;;
esac

for _p in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew "$HOME/.linuxbrew"; do
  [[ -x "$_p/bin/brew" ]] && BREW_PREFIX="$_p" && break
done
unset _p
[[ -n $BREW_PREFIX ]] && path=("$BREW_PREFIX"/{bin,sbin} $path)
