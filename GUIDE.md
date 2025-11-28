# Introduction

This is a minimal Neovim configuration written in Lua. This is not meant to be a distribution, but rather a template for you to build upon and/or a reference for how to configure Neovim using Lua in the latest version.

## Tutor

If you're completely new to Neovim and/or Vim, consider going through `:Tutor` inside Neovim to get a basic idea of how it works.

If you don't know what this means, type the following:
- `<Escape>` key
- `:`
- `Tutor`
- `<Enter>` key

## Lua

Some level of familiarity with Lua/programming languages is also expected. If you're new to Lua, consider going through:

- **Official reference**: https://www.lua.org/manual
- **Friendly tutorial**: https://learnxinyminutes.com/docs/lua/

You can also check out `:h lua-guide` inside Neovim for a Neovim-specific Lua guide.

## Dependencies

This configuration assumes you have the following tools installed on your system:

- `git` - for Vim builtin package manager (see `:h vim.pack`)
- `unzip` - for Mason, specifically for `clangd`, which the config installs by default
- `ripgrep` - for fuzzy finding
- **Clipboard tool**: `xclip`/`xsel`/`win32yank` - for clipboard sharing between OS and Neovim (see `:h clipboard-tool`)
- **Nerd Font** - ensure the terminal running Neovim is using it

Run `:checkhealth` inside Neovim to see if your system is missing anything.

## Minimal

To say that something is 'minimal' you have to define what variable you're minimizing. This configuration minimizes for lines of code and concepts.

To some, this configuration may have too many plugins. For example, using `mason.nvim` to manage LSP servers will be an unnecessary dependency if the user is already familiar with LSPs and is comfortable managing them through their OS package manager. But to someone that isn't familiar with LSP servers, this approach wouldn't cover everything needed to have the 'minimum' necessary for LSP + completion + fuzzy finding. To some, fuzzy finding is also a bloated dependency.

This configuration is only a starting point/reference. It is expected that the user will change the configuration to suit their needs.

# Config

## Options

These change the default Neovim behaviors using the `vim.opt` API.

- See `:h vim.opt` for more details
- Run `:h '{option_name}'` to see what they do and what values they can take
- For example: `:h 'number'` for `vim.opt.number`

### Diagnostics

TODO:

## Plugins

We install plugins with Neovim's builtin package manager: `vim.pack`, and then enable/configure them by calling their setup functions.

(See `:h vim.pack` for more details on how it works)

You can press `gx` on any of the plugin URLs below to open them in your browser and check out their documentation and functionality. Alternatively, you can run `:h {plugin-name}` to read their documentation.

Plugins are then loaded and configured with a call to `setup` functions provided by each plugin. This is not a rule of Neovim but rather a convention followed by the community. These setup calls take a table as an argument and their expected contents can vary wildly. Refer to each plugin's documentation for details.

### Treesitter

TODO:

### Completion

TODO: 

#### Snippets

TODO:

### LSP

TODO: 

#### Tooling

  If you'd rather install the lsps through your OS package manager you

  Can delete the next three mason-related lines and their setup calls below.

  See `:h lsp-quickstart` for more details.

### Fuzzy Finder

TODO:

### Keybind Helper

TODO:
