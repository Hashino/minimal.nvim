# Introduction
`minimal.nvim` comes in two main flavors: `bare-minimum` and `featureful`. 
Whereas the first contains only the bare minimum for having completions + lsp + 
fuzzy finding and sane options in neovim, the featureful version also contains
some quality of life/appearance plugins

if you want the absolte minimal code necessary for having just higlighting + 
lsp diagnostics + completion. check out the [minimal](https://github.com/Hashino/minimal.nvim/tree/minimal/init.lua) branch

## Screenshots

bare-minimum version:
![bare-minimum](screenshots/bare-minimum.png)

featureful version:
![featureful](screenshots/featureful.png)

# Installation
Requires neovim version `0.12` or greater

## Dependencies
- `git` - for vim builtin package manager. (see `:h vim.pack`)
- `unzip` - for [mason](https://github.com/mason-org/mason.nvim), specifically for `clangd`, which the config installs by default
- `ripgrep` - for fuzzy finding 
- clipboard tool: xclip/xsel/win32yank - for clipboard sharing between OS and neovim (see `h: clipboard-tool`)
- a [nerd font](https://www.nerdfonts.com/) (ensure the terminal running neovim is using it)

---

to install run:

<details>
<summary> Linux/MacOS/WSL </summary>

for `bare-minimum`:

```
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && wget https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/bare-minimum/init.lua -O "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua && nvim -c ':e $MYVIMRC'
```

for `featureful`:

```
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && wget https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/featureful/init.lua -O "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua && nvim -c ':e $MYVIMRC'
```
</details>

<details>
<summary> Windows (Powershell) </summary>

for `bare-minimum`:

```powershell
mkdir -Force $env:LOCALAPPDATA\nvim\ && curl https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/bare-minimum/init.lua -o $env:LOCALAPPDATA\nvim\init.lua && nvim -c ':e $MYVIMRC'

```
for `featureful`:

```powershell
mkdir -Force $env:LOCALAPPDATA\nvim\ && curl https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/featureful/init.lua -o $env:LOCALAPPDATA\nvim\init.lua && nvim -c ':e $MYVIMRC'
```
</details>

or download [init.lua](init.lua) via the browser to the neovim config directory:

### Location
Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows | `%localappdata%\nvim\` |
