#!/usr/bin/env bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREW_PREFIX=""
for p in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew "$HOME/.linuxbrew"; do
  if [ -x "$p/bin/brew" ]; then eval "$("$p/bin/brew" shellenv)"; BREW_PREFIX="$p"; break; fi
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

echo "==> Configuring gpg-agent"
mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"
if [[ "$OSTYPE" == darwin* ]]; then
  sed "s|@PINENTRY@|$BREW_PREFIX/bin/pinentry-mac|" "$DOTFILES/.gnupg/gpg-agent.macos.conf" > "$HOME/.gnupg/gpg-agent.conf"
else
  cp "$DOTFILES/.gnupg/gpg-agent.linux.conf" "$HOME/.gnupg/gpg-agent.conf"
fi
chmod 600 "$HOME/.gnupg/gpg-agent.conf"
gpgconf --kill gpg-agent 2>/dev/null || true

echo "==> Installing packages (brew bundle)"
brew bundle --file="$DOTFILES/.config/homebrew/Brewfile"

echo "==> Bootstrapping zsh (antidote plugins install on first run)"
zsh -i -c exit || true

echo
echo "Done. If zsh isn't your login shell yet:"
echo "  chsh -s \"\$(command -v zsh)\""
echo "Then open a new terminal."
