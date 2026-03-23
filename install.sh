#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname -- "$dst")"

  if [ -L "$dst" ]; then
    rm -f -- "$dst"
  elif [ -e "$dst" ]; then
    mv -- "$dst" "${dst}.bak.$(date +%Y%m%d%H%M%S)"
  fi

  ln -s -- "$src" "$dst"
}

link "$repo_dir/config/hypr" "$HOME/.config/hypr"
link "$repo_dir/config/waybar" "$HOME/.config/waybar"
link "$repo_dir/config/wofi" "$HOME/.config/wofi"
link "$repo_dir/config/xdg-desktop-portal" "$HOME/.config/xdg-desktop-portal"

chmod +x "$repo_dir/config/waybar/scripts/bluetooth.sh" || true

echo "Done. Symlinks created in ~/.config"
