[[ -d "$HOME/Android/Sdk" ]] && export ANDROID_HOME="$HOME/Android/Sdk"

if (( ! $+commands[pbcopy] )); then
  if (( $+commands[wl-copy] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  fi
fi

source "$ZDOTDIR/linux/secrets.zsh"
source "$ZDOTDIR/shared/entry.zsh"
