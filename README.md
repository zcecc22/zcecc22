# zcecc22 dotfiles

Minimal [GNOME](https://www.gnome.org/) desktop on Debian Stable, launched via `startx` — no display manager. Solarized Dark in the terminal and editor; Adwaita-dark system-wide.

## Branches

| Branch | Purpose |
|---|---|
| `main` | Alias for `dwm` — default clone target |
| `dwm` | Full X11/dwm desktop environment |
| `gnome` | Full X11/GNOME desktop environment |
| `sway` | Full Sway/Wayland desktop environment |
| `base` | Dev tools and shell config only (no desktop) |

Clone `base` if you only want the shell setup (bash, tmux, git, micro). Clone a desktop branch for a complete environment.

## Stack

| Role | Tool |
|---|---|
| Window Manager | GNOME Shell / mutter (X11) |
| Terminal | gnome-terminal |
| Status Bar | GNOME Shell top bar |
| App Launcher | GNOME Activities (Super) |
| Notifications | GNOME Shell built-in |
| Screen Lock | GNOME Shell built-in |
| File Manager | nautilus |
| Audio | PipeWire (pipewire-pulse + wireplumber) |
| Network | NetworkManager |
| Power Management | TLP |
| Browser | Firefox ESR |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata (mono), Cantarell (UI) |

## Design decisions

- **No display manager** — X starts manually from a TTY via `startx`.
- **Minimal GNOME** — only core packages installed: `gnome-session`, `gnome-shell`, `gnome-control-center`, `gnome-tweaks`, `gnome-terminal`, `nautilus`. No GNOME extras or bundled apps.
- **Adwaita-dark** — system theme set via `/etc/dconf/db/local.d/` so it applies to all users without requiring a running session.
- **NetworkManager** — replaces ifupdown2/wpa_supplicant for GNOME panel integration; `nmcli` available for CLI use.
- **GPG as SSH agent** — `gpg-agent` handles both git commit signing and SSH authentication. A hardware key (e.g. YubiKey) covers both.
- **micro over vim** — lighter, no modal editing, good out-of-the-box defaults for a general-purpose terminal editor.
- **Solarized Dark in the terminal** — consistent palette in gnome-terminal, micro, and `ls` colors.

## Prerequisites

- Debian Stable (trixie)
- TTY login — no display manager needed or installed

## Install

Clone directly into your home directory:

```bash
git clone -b gnome git@github.com:zcecc22/zcecc22.git ~
```

Run the setup scripts:

```bash
~/.bin/base-setup    # dev tools: compilers, languages, utilities
~/.bin/desktop-setup # GNOME packages + dconf system defaults
```

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

GNOME launches directly into a session. Use `gnome-tweaks` to adjust fonts, window decorations, and extensions after first login.

## Network

Managed with NetworkManager.

- **GUI**: GNOME Shell network indicator (top bar)
- **CLI**: `nmcli device wifi connect <SSID> password <pass>`

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
├── .xinitrc                        # X11 session: env vars, exec gnome-session
├── .bin/
│   ├── base-setup                  # Dev tools installer
│   └── desktop-setup               # GNOME installer + dconf defaults
├── .config/
│   └── micro/                      # Editor config + keybindings
└── .gnupg/                         # GPG agent with SSH support
```

## License

Public domain. Use as you like.
