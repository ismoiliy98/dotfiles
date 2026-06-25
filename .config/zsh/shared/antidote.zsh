# Plugin manager (antidote), loaded by shared/entry.zsh via `__load antidote`.
# Bundles: .zsh_plugins.txt (+ .zsh_plugins_pre.txt for fpath completions before compinit).

ANTIDOTE_REPO="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
ANTIDOTE_PRE_TXT="$ZDOTDIR/.zsh_plugins_pre.txt"
ANTIDOTE_PRE_ZSH="$ZDOTDIR/.zsh_plugins_pre.zsh"
ANTIDOTE_MAIN_TXT="$ZDOTDIR/.zsh_plugins.txt"
ANTIDOTE_MAIN_ZSH="$ZDOTDIR/.zsh_plugins.zsh"

if [[ ! -d "$ANTIDOTE_REPO" ]]; then
  echo 'Antidote not found. Installing...'
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_REPO" &>/dev/null ||
    { echo 'Antidote install failed.'; return 1; }
fi

if [[ ! $ANTIDOTE_PRE_ZSH -nt $ANTIDOTE_PRE_TXT || ! $ANTIDOTE_MAIN_ZSH -nt $ANTIDOTE_MAIN_TXT ]]; then
  source "$ANTIDOTE_REPO/antidote.zsh"
  antidote bundle <"$ANTIDOTE_PRE_TXT" >"$ANTIDOTE_PRE_ZSH"
  antidote bundle <"$ANTIDOTE_MAIN_TXT" >"$ANTIDOTE_MAIN_ZSH"
  zcompile -R -- "$ANTIDOTE_PRE_ZSH" 2>/dev/null
  zcompile -R -- "$ANTIDOTE_MAIN_ZSH" 2>/dev/null
fi

source "$ANTIDOTE_PRE_ZSH"

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-antidote-$ZSH_VERSION"
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p "${ZSH_COMPDUMP:h}"
autoload -Uz compinit && compinit -C -d "$ZSH_COMPDUMP"
[[ $ZSH_COMPDUMP.zwc -nt $ZSH_COMPDUMP ]] || zcompile -R -- "$ZSH_COMPDUMP" 2>/dev/null

source "$ANTIDOTE_MAIN_ZSH"

[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

unset ANTIDOTE_PRE_TXT ANTIDOTE_PRE_ZSH ANTIDOTE_MAIN_TXT ANTIDOTE_MAIN_ZSH
