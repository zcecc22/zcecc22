# Dotfiles - Sway Desktop on Debian Stable

## Philosophy
- Minimalist: avoid duplication of application roles
- Two install scripts: `.bin/base-setup` (dev tools) and `.bin/desktop-setup` (desktop env)
- Solarized Dark theme applied consistently across all tools
- Network via ifupdown2 + wpa_supplicant (no NetworkManager)
- No display manager or auto-launch: start Sway manually via `~/.bin/start-desktop`

## System Components

| Role | Application |
|---|---|
| Window Manager | Sway (Wayland) + autotiling |
| Power Management | TLP + tlp-pd (power profiles via DBus) |
| X11 Compatibility | XWayland |
| Terminal | Alacritty |
| App Launcher | tofi |
| Status Bar | Waybar |
| Notifications | mako |
| Screen Lock | swaylock + swayidle |
| Browser | Firefox ESR |
| Audio | PipeWire (pipewire-pulse + wireplumber) |
| Clipboard | wl-clipboard |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata (text), Font Awesome (waybar icons) |

## Hardware Target
Laptop - includes brightness control (brightnessctl), battery status, lid handling.

## Sway Defaults
- Mod key: Super/Logo
- Wallpaper: solid solarized base03 (#002b36)
- Startup brightness: 40% via brightnessctl
- Tiling: autotiling daemon — split direction chosen automatically by container aspect ratio
- Auto-lock: swayidle — lock after 5 min idle, display off after 10 min
- Power profiles: tlp-pd via Waybar — click to cycle performance/balanced/power-saver
- DBus/systemd env: `dbus-update-activation-environment` propagates `WAYLAND_DISPLAY`, `DISPLAY`, `XDG_CURRENT_DESKTOP` on startup (required for portals and screen sharing)

## Theme: Solarized Dark Palette
```
base03:  #002b36   (background)
base02:  #073642   (background highlights)
base01:  #586e75   (comments, secondary content)
base00:  #657b83   (body text on light bg)
base0:   #839496   (body text)
base1:   #93a1a1   (optional emphasized content)
base2:   #eee8d5   (background on light)
base3:   #fdf6e3   (background on light)
yellow:  #b58900
orange:  #cb4b16
red:     #dc322f
magenta: #d33682
violet:  #6c71c4
blue:    #268bd2
cyan:    #2aa198
green:   #859900
```

## Repository Structure

### Existing Dotfiles
- `.bashrc` - Shell config, aliases, GPG agent, PATH
- `.bash_profile` - Sources .bashrc
- `.inputrc` - Readline (case-insensitive completion)
- `.tmux.conf` - Ctrl-A prefix, mouse on, status bar off
- `.dir_colors` - Solarized ls colors
- `.gitconfig` - GPG-signed commits, user config
- `.gitignore` - Global ignores
- `.npmrc` - npm prefix
- `.config/micro/` - Solarized theme, keybindings
- `.gnupg/` - GPG agent with SSH support

### Scripts (.bin/)
- `base-setup` - Dev tools package installation
- `desktop-setup` - Desktop environment package installation
- `start-desktop` - Wayland env vars, startup brightness, exec sway

### Desktop Config Files
- `.config/sway/config` - Sway WM configuration
- `.config/alacritty/alacritty.toml` - Terminal configuration
- `.config/waybar/config` - Status bar modules
- `.config/waybar/style.css` - Status bar styling
- `.config/mako/config` - Notification daemon styling
- `.config/swaylock/config` - Lock screen styling
- `.config/tofi/config` - App launcher styling
