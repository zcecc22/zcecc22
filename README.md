# zcecc22 dotfiles

Minimalist [dwm](https://dwm.suckless.org/) desktop on Debian Stable. Solarized Dark across every tool. One role per tool, no overlap.

## Branches

| Branch | Purpose |
|---|---|
| `dwm` | Full X11/dwm desktop environment |
| `sway` | Full Sway/Wayland desktop environment |
| `base` | Dev tools and shell config only (no desktop) |

Clone `base` if you only want the shell setup (bash, tmux, git, micro). Clone `dwm` or `sway` for a complete desktop.

## Stack

| Role | Tool |
|---|---|
| Window Manager | dwm (X11, master-stack tiling) |
| Terminal | Alacritty |
| Status Bar | slstatus |
| App Launcher | dmenu |
| Notifications | dunst |
| Screen Lock | slock + xautolock |
| Audio | PipeWire (pipewire-pulse + wireplumber) |
| Clipboard | xclip |
| Power Management | TLP + tlp-rdw |
| Browser | Firefox ESR |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata |

## Design decisions

- **No display manager** — X starts manually from a TTY via `startx`.
- **Suckless tools as source** — dwm, slock, and slstatus live as full upstream source trees in the repo. `config.h` is the only file edited. `desktop-setup` builds all three.
- **No NetworkManager** — `ifupdown2` and `wpa_supplicant` are sufficient for a single machine and keep the service footprint minimal.
- **GPG as SSH agent** — `gpg-agent` handles both git commit signing and SSH authentication. A hardware key (e.g. YubiKey) covers both.
- **micro over vim** — lighter, no modal editing, good out-of-the-box defaults for a general-purpose terminal editor.
- **Solarized Dark everywhere** — consistent palette across Alacritty, dunst, slock, slstatus, micro, and `ls` colors.

## Prerequisites

- Debian Stable (trixie)
- TTY login — no display manager needed or installed

## Install

Clone directly into your home directory:

```bash
git clone -b dwm git@github.com:zcecc22/zcecc22.git ~
```

Run the setup scripts:

```bash
~/.bin/base-setup    # dev tools: compilers, languages, utilities
~/.bin/desktop-setup # dwm, slock, slstatus (builds from source), plus desktop packages
```

`desktop-setup` builds all three Suckless binaries and installs them to `~/.bin/`. slock receives setuid root via two targeted `sudo` commands so it can lock the session.

**Shell config only** (branch `base`):

```bash
git clone -b base git@github.com:zcecc22/zcecc22.git ~
~/.bin/base-setup
```

## Usage

Start X from a TTY:

```bash
startx
```

### Key bindings

`Super` (Logo key) is the mod key.

| Key | Action |
|---|---|
| `Super+Shift+Return` | Open terminal |
| `Super+p` | App launcher (dmenu) |
| `Super+Shift+c` | Close window |
| `Super+j` / `Super+k` | Focus next / prev window |
| `Super+h` / `Super+l` | Shrink / grow master area |
| `Super+i` / `Super+d` | Increase / decrease master count |
| `Super+Return` | Promote focused window to master |
| `Super+Tab` | Toggle last tag |
| `Super+1–9` | Switch tag |
| `Super+Shift+1–9` | Move window to tag |
| `Super+0` | View all tags |
| `Super+t` | Tile layout |
| `Super+f` | Float layout |
| `Super+m` | Monocle layout |
| `Super+Space` | Toggle last layout |
| `Super+Shift+Space` | Toggle floating |
| `Super+b` | Toggle status bar |
| `Super+,` / `Super+.` | Focus prev / next monitor |
| `Super+Shift+l` | Lock screen (slock) |
| `Super+Shift+q` | Quit dwm |

Brightness and volume keys work out of the box via `brightnessctl` and `wpctl`.

### Idle behavior

| Condition | Action |
|---|---|
| 5 min idle | xautolock triggers slock |
| DPMS standby | 5 min |
| DPMS suspend / off | 10 min |

### Mouse

| Action | Result |
|---|---|
| `Super+Button1` drag | Move window |
| `Super+Button2` | Toggle floating |
| `Super+Button3` drag | Resize window |

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
├── .bash_profile                   # Sources .bashrc
├── .inputrc                        # Readline: completion, history search
├── .tmux.conf                      # Ctrl-A prefix, mouse on
├── .dir_colors                     # Solarized ls colors
├── .gitconfig                      # GPG signing, modern diff/merge defaults
├── .gitignore                      # Global ignores
├── .npmrc                          # npm prefix
├── .xinitrc                        # X11 session: env, wallpaper, autolock, slstatus, exec dwm
├── .bin/
│   ├── base-setup                  # Dev tools installer
│   └── desktop-setup               # Desktop env installer + Suckless build
├── .dwm/
│   └── config.h                    # dwm: colors, font, keybindings, rules, layouts
├── .slock/
│   └── config.h                    # slock: Solarized lock screen colors
├── .slstatus/
│   └── config.h                    # slstatus: battery, brightness, volume, datetime
├── .config/
│   ├── alacritty/alacritty.toml    # Terminal
│   ├── dunst/dunstrc               # Notification daemon styling
│   └── micro/                      # Editor config + keybindings
└── .gnupg/                         # GPG agent with SSH support
```

## License

Public domain. Use as you like.
