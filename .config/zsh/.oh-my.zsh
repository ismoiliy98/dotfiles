export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

if [ ! -d "$ZSH" ]; then
  echo 'Oh My Zsh not found. Installing...'

  OMZ_REPO='https://raw.githubusercontent.com/ohmyzsh/ohmyzsh'
  sh -c "$(curl -fsSL "$OMZ_REPO/master/tools/install.sh")" '' --unattended --keep-zshrc

  echo 'Oh My Zsh installed.'
fi

if [ ! -f "$ZSH/oh-my-zsh.sh" ]; then
  echo 'OMZ shell script is not found!'
  return 1
fi

__load 'omz-plugins'
__ensure_omz 'theme' 'romkatv/powerlevel10k'

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

ZSH_THEME='powerlevel10k/powerlevel10k'
DISABLE_MAGIC_FUNCTIONS='true'
DISABLE_AUTO_TITLE='true'

source "$ZSH/oh-my-zsh.sh"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
