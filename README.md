# Installation
Requires neovim version `0.12` or greater

## Dependencies
- `git`
- `unzip`
- `ripgrep`
- clipboard tool (linux only)
- a nerd font (ensure the terminal running neovim is using it)

to install run:
```bash
mkdir "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && wget https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/main/init.lua -O "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua && nvim
```

preferably, fork the repo and clone the fork instead
