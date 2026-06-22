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

__load plugins
__ensure_omz 'theme' 'romkatv/powerlevel10k'

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

ZSH_THEME='powerlevel10k/powerlevel10k'
DISABLE_MAGIC_FUNCTIONS='true'
DISABLE_AUTO_TITLE='true'
ZSH_DISABLE_COMPFIX='true'
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}

source "$ZSH/oh-my-zsh.sh"
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"
