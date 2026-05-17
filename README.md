# zcecc22 dotfiles

Minimalist [Sway](https://swaywm.org/) desktop on Debian Stable. Solarized Dark across every tool. One role per tool, no overlap.

## Branches

| Branch | Purpose |
|---|---|
| `main` | Full Sway/Wayland desktop environment |
| `base` | Dev tools and shell config only (no desktop) |

Clone `base` if you only want the shell setup (bash, tmux, git, micro). Clone `main` for the complete desktop.

## Stack

| Role | Tool |
|---|---|
| Window Manager | Sway (Wayland) |
| Terminal | Alacritty |
| Status Bar | Waybar |
| App Launcher | tofi |
| Notifications | mako |
| Screen Lock | swaylock + swayidle |
| Audio | PipeWire |
| Browser | Firefox ESR |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata, Font Awesome |

## Design decisions

- **No display manager** — Sway starts directly from a TTY via `~/.bin/start-desktop`.
- **No NetworkManager** — `ifupdown2` and `wpa_supplicant` are sufficient for a single machine and keep the service footprint minimal.
- **GPG as SSH agent** — `gpg-agent` handles both git commit signing and SSH authentication. A hardware key (e.g. YubiKey) covers both.
- **micro over vim** — lighter, no modal editing, good out-of-the-box defaults for a general-purpose terminal editor.
- **Solarized Dark everywhere** — consistent palette across Alacritty, Waybar, mako, swaylock, tofi, micro, and `ls` colors.

## Prerequisites

- Debian Stable (trixie)
- TTY login — no display manager needed or installed

## Install

Clone directly into your home directory:

```bash
git clone git@github.com:zcecc22/zcecc22.git ~
```

Run the setup scripts:

```bash
~/.bin/base-setup    # dev tools: compilers, languages, utilities
~/.bin/desktop-setup # Sway, Alacritty, Waybar, and the rest
```

**Shell config only** (branch `base`):

```bash
git clone -b base git@github.com:zcecc22/zcecc22.git ~
~/.bin/base-setup
```

## Usage

Start Sway from a TTY:

```bash
~/.bin/start-desktop
```

### Key bindings

`Super` is the mod key.

| Key | Action |
|---|---|
| `Super+Return` | Open terminal |
| `Super+d` | App launcher |
| `Super+Shift+q` | Close window |
| `Super+1–9` | Switch workspace |
| `Super+Shift+1–9` | Move window to workspace |
| `Super+f` | Fullscreen |
| `Super+Space` | Toggle floating |
| `Super+h` / `Super+v` | Split horizontal / vertical |
| `Super+r` | Resize mode (arrows to resize, Esc to exit) |
| `Super+l` | Lock screen |
| `Super+Shift+c` | Reload config |
| `Super+Shift+e` | Exit Sway |

Brightness and volume keys work out of the box via `brightnessctl` and `wpctl`.

### Idle behavior

| Idle time | Action |
|---|---|
| 5 min | Screen locks |
| 10 min | Display powers off |
| On suspend | Locks automatically |

## Network

Managed with `ifupdown2` and `wpa_supplicant`.

- **Wired**: configure `/etc/network/interfaces`
- **WiFi**: add credentials to `/etc/wpa_supplicant/wpa_supplicant.conf`, then bring up the interface with `ifup`

## Shell highlights

Some non-obvious things the bash configuration sets up:

- **GPG as SSH agent** — `SSH_AUTH_SOCK` points to the gpg-agent socket; the same hardware key handles SSH and git signing
- **Prefix-aware history search** — Up/Down arrows search history starting with what you've already typed (configured in `.inputrc`)
- **Timestamped history** — `history` output includes date and time of each command
- **tmux auto-attach** — `tmux` always attaches to a persistent session named `0`, creating it if needed
- **Solarized `ls`** — directory and file type colors via `.dir_colors`

## Structure

```
~
├── .bashrc                         # Shell config, aliases, GPG agent
├── .inputrc                        # Readline: completion, history search
├── .tmux.conf                      # Ctrl-A prefix, Esc fix, scrollback
├── .dir_colors                     # Solarized ls colors
├── .gitconfig                      # GPG signing, modern diff/merge defaults
├── .gitignore                      # Global ignores
├── .npmrc                          # npm prefix
├── .bin/
│   ├── base-setup                  # Dev tools installer
│   ├── desktop-setup               # Desktop env installer
│   ├── start-desktop               # Launch Sway
│   └── convert-mp4                 # Batch video conversion
├── .config/
│   ├── sway/config                 # Window manager
│   ├── alacritty/alacritty.toml    # Terminal
│   ├── waybar/config               # Status bar modules
│   ├── waybar/style.css            # Status bar styling
│   ├── mako/config                 # Notification daemon
│   ├── swaylock/config             # Lock screen
│   ├── tofi/config                 # App launcher
│   └── micro/                      # Editor config + keybindings
└── .gnupg/                         # GPG agent with SSH support
```

## License

Public domain. Use as you like.
