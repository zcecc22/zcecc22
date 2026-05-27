# Dotfiles - GNOME Desktop on Debian Stable

## Philosophy
- Minimalist: avoid duplication of application roles
- Two install scripts: `.bin/base-setup` (dev tools) and `.bin/desktop-setup` (desktop env)
- GNOME Shell on Xorg, launched manually via `startx` — no display manager
- Solarized Dark terminal and editor themes; GNOME uses Adwaita-dark system-wide
- Network via NetworkManager
- No display manager: start X manually via `startx`

## System Components

| Role | Application |
|---|---|
| Window Manager | GNOME Shell / mutter (X11) |
| Status Bar | GNOME Shell top bar |
| App Launcher | GNOME Activities (Super key) |
| Screen Lock | GNOME Shell built-in |
| Notifications | GNOME Shell built-in |
| Terminal | gnome-terminal |
| File Manager | nautilus |
| Browser | Firefox ESR |
| Audio | PipeWire (pipewire-pulse + wireplumber) |
| Network | NetworkManager |
| Power Management | TLP |
| Editor | micro |
| Shell | bash |
| Multiplexer | tmux |
| Fonts | Inconsolata (mono), Cantarell (UI) |

## Hardware Target
Laptop — includes brightness control (brightnessctl), battery status, lid handling.

## GNOME Defaults (applied by desktop-setup via dconf)
- Theme: Adwaita-dark
- Color scheme: prefer-dark
- Monospace font: Inconsolata 11
- UI font: Cantarell 11
- Window buttons: minimize, maximize, close
- Screen lock: immediate on idle
- Idle timeout: 5 minutes

## Theme: Solarized Dark Palette
Used in terminal (gnome-terminal), editor (micro), and shell prompt.
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

### Dotfiles
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
- `desktop-setup` - Desktop environment package installation and GNOME dconf defaults

### Session and Config Files
- `.xinitrc` - X11 session: env vars, exec gnome-session
