# Introduction
this is the absolute minimal [init.lua](init.lua) you'll neeed for having highlighting + lsp
diagnostics + completion (without having your own `/lua/{server}.lua` configs)

# Installation
Requires neovim version `0.12` or greater

## Dependencies
- `git` - for vim builtin package manager. (see `:h vim.pack`)
- `lua-language-server` - lsp to be used wit the config

---

to install run:

<details>
<summary> Linux/MacOS/WSL </summary>

```bash
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && wget https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/minimal/init.lua -O "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua && nvim -c ':e $MYVIMRC'
```
</details>

<details>
<summary> Windows (Powershell) </summary>

```powershell
mkdir -Force $env:LOCALAPPDATA\nvim\ && curl https://raw.githubusercontent.com/Hashino/minimal.nvim/refs/heads/minimal/init.lua -o $env:LOCALAPPDATA\nvim\init.lua && nvim -c ':e $MYVIMRC'
```
</details>

or download [init.lua](init.lua) via the browser to the neovim config directory:

### Location
Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows | `%localappdata%\nvim\` |
