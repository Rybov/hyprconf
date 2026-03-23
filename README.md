# hyprconf

This directory contains a snapshot of the Hyprland + Waybar + Wofi configuration.

## Layout

- `config/hypr/`
- `config/waybar/`
- `config/wofi/`
- `config/xdg-desktop-portal/`

## Arch Linux dependencies

Core session:

- hyprland
- hyprpaper
- hypridle
- hyprlock
- waybar
- wofi
- kitty

Audio / network / notifications:

- pipewire
- wireplumber
- pavucontrol
- networkmanager
- nm-connection-editor
- swaync

Bluetooth:

- bluez
- bluez-utils
- blueman

Portals + auth (recommended when GNOME and Hyprland share one install):

- xdg-desktop-portal
- xdg-desktop-portal-gtk
- xdg-desktop-portal-hyprland
- polkit-gnome

Fonts (recommended for icons):

- ttf-jetbrains-mono-nerd
- noto-fonts

## Install

Run:

```bash
bash install.sh
```

It will create symlinks into `~/.config/`.

## Notes

- The Hyprland config currently starts polkit agent conditionally:
  `polkit-gnome-authentication-agent-1` if installed.