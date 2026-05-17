# dotfiles

Minimal Sway desktop environment on Debian Stable. Solarized Dark everywhere.

## Stack

| | |
|---|---|
| WM | Sway |
| Terminal | Alacritty |
| Bar | Waybar |
| Launcher | tofi |
| Notifications | mako |
| Lock | swaylock + swayidle |
| Audio | PipeWire |
| Browser | Firefox ESR |
| Editor | micro |
| Shell | bash |
| Fonts | Inconsolata, Font Awesome |

## Install

Requires Debian Stable. Clone into your home directory:

```bash
git clone https://github.com/YOUR_USER/dotfiles.git ~
```

Run the setup scripts:

```bash
# Dev tools (compilers, languages, utilities)
~/.bin/system_setup

# Desktop environment (sway, alacritty, waybar, etc.)
~/.bin/desktop-setup
```

## Usage

Start Sway from a TTY:

```bash
~/.bin/start-desktop
```

### Key Bindings

`Super` is the mod key.

| Key | Action |
|---|---|
| `Super+Return` | Open terminal |
| `Super+d` | App launcher |
| `Super+Shift+q` | Close window |
| `Super+1-9` | Switch workspace |
| `Super+Shift+1-9` | Move window to workspace |
| `Super+f` | Fullscreen |
| `Super+space` | Toggle floating |
| `Super+h` / `Super+v` | Split horizontal / vertical |
| `Super+r` | Resize mode (arrows to resize, Esc to exit) |
| `Super+l` | Lock screen |
| `Super+Shift+c` | Reload config |
| `Super+Shift+e` | Exit Sway |

Brightness and volume keys work out of the box via brightnessctl and wpctl.

### Idle Behavior

- 5 min: screen locks
- 10 min: display powers off
- Locks automatically before suspend

## Network

Uses ifupdown2 + wpa_supplicant. Configure interfaces in `/etc/network/interfaces` and WiFi credentials in `/etc/wpa_supplicant/wpa_supplicant.conf`.

## Structure

```
~
├── .bashrc                         # Shell config, aliases, PATH
├── .bash_profile                   # Sources .bashrc
├── .bash_logout                    # GPG agent cleanup
├── .inputrc                        # Readline config
├── .tmux.conf                      # tmux config
├── .dir_colors                     # Solarized ls colors
├── .gitconfig                      # Git + GPG signing
├── .gitignore                      # Global ignores
├── .npmrc                          # npm prefix
├── .bin/
│   ├── system_setup                # Dev tools installer
│   ├── desktop-setup               # Desktop env installer
│   ├── start-desktop               # Launch Sway
│   └── convert-mp4                 # Batch video conversion
├── .config/
│   ├── sway/config                 # Window manager
│   ├── alacritty/alacritty.toml    # Terminal
│   ├── waybar/config               # Status bar modules
│   ├── waybar/style.css            # Status bar styling
│   ├── mako/config                 # Notifications
│   ├── swaylock/config             # Lock screen
│   ├── tofi/config                 # App launcher
│   └── micro/                      # Editor config
├── .gnupg/                         # GPG agent + SSH
└── .ssh/                           # SSH keys
```

## License

Public domain. Use as you like.
