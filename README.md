# Introduction
Minimal neovim config for lsp + completion + highlighting. Also provides a fuzzy
finder and some quality-of-life plugins.

![screenshot](screenshot.png)

# Installation
Requires neovim version `0.12` or greater

## Dependencies
- `git`
- `unzip`
- `ripgrep`
- clipboard tool: xclip/xsel/win32yank
- a nerd font (ensure the terminal running neovim is using it)

to install run:
```bash
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && wget https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/main/init.lua -O "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua && nvim
```
or dowload [init.lua](init.lua) to the neovim config directory:

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows | `%localappdata%\nvim\` |
