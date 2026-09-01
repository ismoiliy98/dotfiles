#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

for p in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew "$HOME/.linuxbrew"; do
  if [ -x "$p/bin/brew" ]; then eval "$("$p/bin/brew" shellenv)"; break; fi
done

for tool in stow zsh; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "==> Installing $tool"
    brew install "$tool"
  fi
done

echo "==> Linking dotfiles into \$HOME"
mkdir -p "$HOME/.config"
(cd "$DOTFILES" && stow --target="$HOME" --restow .)

echo "==> Installing packages (brew bundle)"
brew bundle --file="$DOTFILES/.config/homebrew/Brewfile"

echo "==> Bootstrapping zsh (antidote plugins install on first run)"
zsh -i -c exit || true

echo
echo "Done. If zsh isn't your login shell yet:"
echo "  chsh -s \"\$(command -v zsh)\""
echo "Then open a new terminal."
