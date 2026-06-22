source "$ZDOTDIR/shared/helpers.zsh"

if [[ -n $DOTFILES_OS && -r "$ZDOTDIR/$DOTFILES_OS/entry.zsh" ]]; then
  source "$ZDOTDIR/$DOTFILES_OS/entry.zsh"
else
  source "$ZDOTDIR/shared/entry.zsh"
fi
