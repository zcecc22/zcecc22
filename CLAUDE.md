# Dotfiles - dwm Desktop on Debian Stable

## Philosophy
- Minimalist: avoid duplication of application roles
- Two install scripts: `.bin/base-setup` (dev tools) and `.bin/desktop-setup` (desktop env)
- Suckless tools (dwm, slstatus, st) managed as source in project root, configured via `config.h`
- Solarized Dark theme applied consistently across all tools
- Network via ifupdown + wpa_supplicant (no NetworkManager)
- No display manager or auto-launch: start X manually via `startx`

## System Components

| Role | Application |
|---|---|
| Window Manager | dwm (X11, master-stack tiling) |
| Status Bar | dwm built-in + slstatus |
| App Launcher | dmenu |
| Notifications | dunst |
| Terminal | st |
| Browser | Firefox ESR |
| Audio | PipeWire (pipewire-pulse + wireplumber) |
| Clipboard | xclip |
| Power Management | TLP |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata, Font Awesome 6 Free |

## Hardware Target
Laptop - includes brightness control (brightnessctl), battery status, lid handling.

## dwm Defaults
- Mod key: Super/Logo (Mod4)
- Wallpaper: solid solarized base03 (#002b36) via xsetroot
- Tiling: master-stack built-in; Mod+t/m to switch tile/monocle
- Status bar: slstatus — battery (icon+%), brightness (icon+%), volume (icon+%), network (wifi essid or eth), datetime
- Startup brightness: 15% via brightnessctl
- Screen off: xset dpms 300 600 600 (standby/suspend 5 min, off 10 min)

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

### Suckless Sources (.dwm/, .slstatus/, .st/)
Each directory contains the full upstream source. `config.h` is the only file edited.
`desktop-setup` builds all three and moves binaries to `.bin/`.

- `.dwm/config.h` - dwm: colors, font, keybindings, rules, layouts
- `.slstatus/config.h` - slstatus: battery, brightness, volume, network, datetime (Font Awesome icons via bat-status/vol-status/net-status)
- `.st/config.h` - st: Solarized colors, font, clipboard shortcuts

### Scripts (.bin/)
- `base-setup` - Dev tools package installation
- `desktop-setup` - Desktop environment package installation and suckless build
- `system-setup` - Bare-metal Debian installer (partition, debootstrap, GRUB, user creation)
- `bat-status` - Battery icon (level-dependent) + bolt if charging + %
- `vol-status` - Volume icon (mute-aware) + %
- `net-status` - Wifi essid or ethernet indicator with FA icons

### Session and Config Files
- `.xinitrc` - X11 session: PATH, env vars, xsetroot, dunst, slstatus, exec dwm
- `.config/dunst/dunstrc` - Notification daemon styling
