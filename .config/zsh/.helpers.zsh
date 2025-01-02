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

__ensure_omz() {
  local type="$1"
  local input="$2"
  local overrideName="$3"
  local defaultAuthor="zsh-users"

  if [[ -z "$type" || -z "$input" ]]; then
    echo "Usage: __ensure_omz <plugin|theme> <author/plugin|plugin> [overrideName]"
    return 1
  fi

  if [[ "$type" != "plugin" && "$type" != "theme" ]]; then
    echo "[OMZ] Error: first argument must be 'plugin' or 'theme'."
    return 1
  fi

  local author
  local repoName
  if [[ "$input" = */* ]]; then
    author="${input%%/*}"
    repoName="${input##*/}"
  else
    author="$defaultAuthor"
    repoName="$input"
  fi

  local localName="${overrideName:-$repoName}"

  local baseDir
  if [[ "$type" == "plugin" ]]; then
    baseDir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  else
    baseDir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
  fi

  local targetDir="$baseDir/$localName"

  if [[ -d "$targetDir" ]]; then
    return 0
  fi

  local repoUrl="https://github.com/$author/$repoName.git"
  echo "[OMZ] Installing $type '$localName' from '$repoUrl'..."
  git clone --depth=1 "$repoUrl" "$targetDir" &>/dev/null &&
    echo "[OMZ] $type '$localName' installed successfully." ||
    echo "[OMZ] Error installing $type '$localName'."
}

__cleanup() {
  unfunction __load __add_to_path
  unset -f __cleanup
}
