# Neovim Core Concepts

This document explains the core Neovim concepts used in `init.lua`, with references to specific examples from the configuration file.

## Table of Contents

1. [Vim Global Variables](#vim-global-variables)
2. [Options Configuration](#options-configuration)
3. [Plugin Management](#plugin-management)
4. [Keymaps](#keymaps)
5. [Module Loading](#module-loading)
6. [Diagnostic Configuration](#diagnostic-configuration)
7. [LSP Configuration](#lsp-configuration)

---

## Vim Global Variables

Neovim provides global variables through the `vim.g` table for setting editor-wide configurations.

### Leader Keys

**Lines 5-6:**
```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

The leader key is a prefix key used for custom keybindings. Setting it to `<space>` makes it easily accessible. The `mapleader` is used for global mappings, while `maplocalleader` is used for buffer-local mappings. These must be set before plugins are loaded to ensure they recognize the correct leader key.

---

## Options Configuration

Neovim options are configured using the `vim.opt` table, which provides a Lua-friendly interface to Vim's `:set` command.

### Display Options

**Lines 9, 12-13:**
```lua
vim.opt.termguicolors = true    -- Enable 24-bit RGB colors
vim.opt.number = true            -- Show absolute line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
```

These options control how the editor displays content. True color support enables more vibrant colorschemes. Line numbers help with navigation, and relative numbers make it easier to use motion commands like `10j` or `5k`.

**Lines 16, 19:**
```lua
vim.opt.mouse = "a"              -- Enable mouse support in all modes
vim.opt.showmode = false         -- Hide mode display (e.g., "-- INSERT --")
```

Mouse support allows clicking, scrolling, and selecting text. Hiding the mode display is common when using a status line plugin that already shows the mode.

### Clipboard Integration

**Line 24:**
```lua
vim.opt.clipboard = "unnamedplus"
```

This synchronizes Neovim's default register with the system clipboard, allowing seamless copy-paste between Neovim and other applications.

### Indentation and Formatting

**Lines 27, 69-72:**
```lua
vim.opt.breakindent = true       -- Wrapped lines preserve indentation
vim.opt.tabstop = 2              -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2           -- Number of spaces for each indentation level
vim.opt.expandtab = true         -- Convert tabs to spaces
vim.opt.textwidth = 80           -- Maximum line width
```

These options control how text is indented and formatted. `expandtab` ensures spaces are used instead of tabs, maintaining consistency across different editors.

### File Management

**Line 30:**
```lua
vim.opt.undofile = true
```

Enables persistent undo history, allowing you to undo changes even after closing and reopening a file.

### Search Behavior

**Lines 33-34, 63:**
```lua
vim.opt.ignorecase = true        -- Case-insensitive searching
vim.opt.smartcase = true         -- Case-sensitive if pattern contains uppercase
vim.opt.hlsearch = true          -- Highlight search results
```

These options make searching more intelligent: searches are case-insensitive by default but become case-sensitive when you include uppercase letters.

### Editor Behavior

**Lines 37, 40, 44:**
```lua
vim.opt.signcolumn = "yes"       -- Always show sign column (left gutter)
vim.opt.updatetime = 250         -- Faster completion and diagnostics (milliseconds)
vim.opt.timeoutlen = 300         -- Time to wait for mapped sequence (milliseconds)
```

The sign column displays diagnostic signs, git changes, and other indicators. Reducing `updatetime` makes the editor more responsive for autocompletion and diagnostics.

### Split Behavior

**Lines 47-48:**
```lua
vim.opt.splitright = true        -- Vertical splits open to the right
vim.opt.splitbelow = true        -- Horizontal splits open below
```

These options make split behavior more intuitive, matching how most modern editors create new panes.

### Whitespace Display

**Lines 53-54:**
```lua
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }
```

Makes invisible characters visible, helping identify unwanted whitespace and formatting issues.

### Live Preview

**Lines 57, 60, 66:**
```lua
vim.opt.inccommand = "split"     -- Live preview for substitutions
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.wrap = true              -- Enable line wrapping
```

`inccommand` shows a live preview in a split window when using substitute commands (`:s`), making it easier to see changes before applying them.

---

## Plugin Management

Neovim 0.10+ includes a built-in package manager accessed through `vim.pack`.

### Adding Plugins

**Lines 90, 94, 120:**
```lua
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" }, { confirm = false })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })
```

`vim.pack.add()` downloads and installs plugins from their GitHub URLs. The `confirm = false` option skips confirmation prompts during installation.

### Adding Multiple Plugins

**Lines 177-182, 210-213:**
```lua
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
}, { confirm = false })
```

Multiple plugins can be added in a single call by passing them as a table.

### Colorscheme

**Line 91:**
```lua
vim.cmd.colorscheme("kanagawa")
```

After adding a colorscheme plugin, `vim.cmd.colorscheme()` activates it. This is equivalent to running `:colorscheme kanagawa` in command mode.

---

## Keymaps

Keymaps define keyboard shortcuts using `vim.keymap.set()`.

### Basic Keymap

**Line 87:**
```lua
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

This maps the `Escape` key in normal mode (`"n"`) to clear search highlighting. The `<cmd>` syntax runs an ex command, and `<CR>` simulates pressing Enter.

### Keymap with Options

**Lines 197-198, 200-201:**
```lua
vim.keymap.set("n", "grd", vim.lsp.buf.definition,
  { buffer = bufnr, desc = "vim.lsp.buf.definition()", })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
  { buffer = bufnr, desc = "LSP: [F]ormat Document", })
```

Keymaps can include options:
- `buffer = bufnr`: Makes the keymap buffer-local (only active in specific buffer)
- `desc = "..."`: Provides a description shown by which-key plugin

### Telescope Keymaps

**Lines 222-230:**
```lua
vim.keymap.set("n", "<leader>sp", pickers.builtin, { desc = "[S]earch Builtin [P]ickers", })
vim.keymap.set("n", "<leader>sb", pickers.buffers, { desc = "[S]earch [B]uffers", })
vim.keymap.set("n", "<leader>sf", pickers.find_files, { desc = "[S]earch [F]iles", })
```

These create keymaps with leader key combinations. For example, `<leader>sf` (Space + s + f) triggers the file finder. The descriptive names help users remember what each mapping does.

---

## Module Loading

Neovim plugins and Lua modules are loaded using the `require()` function.

### Loading and Calling Functions

**Line 97:**
```lua
require("nvim-treesitter.install").update("all")
```

This loads the `nvim-treesitter.install` module and immediately calls its `update()` function, equivalent to running `:TSUpdate`.

### Loading and Configuring

**Lines 99-117:**
```lua
require("nvim-treesitter.configs").setup({
  sync_install = true,
  ensure_installed = {
    "lua",
    "c",
    "rust",
    "go",
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
})
```

Most plugins expose a `setup()` function that accepts a configuration table. This pattern is standard across the Neovim plugin ecosystem.

### Storing Module Reference

**Line 220:**
```lua
local pickers = require("telescope.builtin")
```

You can store the result of `require()` in a variable for repeated use, avoiding multiple require calls.

---

## Diagnostic Configuration

Neovim's built-in diagnostic system displays errors, warnings, and hints from LSP servers.

### Diagnostic Configuration

**Lines 74-84:**
```lua
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true,
})
```

This configures diagnostic display:
- `signs.text`: Sets custom icons for each severity level in the sign column
- `virtual_text = true`: Shows diagnostic messages inline at the end of lines

---

## LSP Configuration

The Language Server Protocol (LSP) provides IDE-like features such as autocompletion, go-to-definition, and error checking.

### Server Configuration Table

**Lines 163-175:**
```lua
local lsp_servers = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim", },
        undefined_global = false,
      },
    },
  },
  clangd = {},
  rust_analyzer = {},
  gopls = {},
}
```

This table defines which LSP servers to install and their settings. Each server has a key (server name) and a value (configuration table). Empty tables `{}` use default settings.

### Mason Setup

**Lines 184-188:**
```lua
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})
```

Mason is a package manager for LSP servers, formatters, and linters. `vim.tbl_keys(lsp_servers)` extracts all server names from the configuration table, ensuring they're installed automatically.

### LSP Server Configuration

**Lines 191-204:**
```lua
for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition,
        { buffer = bufnr, desc = "vim.lsp.buf.definition()", })
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
        { buffer = bufnr, desc = "LSP: [F]ormat Document", })
    end,
  })
end
```

This loop configures each LSP server:
- `vim.lsp.config()`: Registers server configuration
- `settings = config`: Passes server-specific settings
- `on_attach`: Callback function that runs when a server successfully attaches to a buffer, perfect for setting buffer-local keymaps

The `on_attach` function receives the client and buffer number (`bufnr`), allowing you to create keymaps that only work in buffers with active LSP support.

---

## Additional Concepts

### Lua Tables

**Line 54:**
```lua
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }
```

Lua tables (dictionaries/arrays) are used extensively for configuration. Keys and values are separated by `=`, and entries by commas.

### Conditional Logic with Loops

**Line 191:**
```lua
for server, config in pairs(lsp_servers) do
```

The `for...in pairs()` loop iterates over table entries, making it easy to apply the same logic to multiple items.

### Function References vs Calls

- `vim.lsp.buf.definition` (line 197): Function reference, called when keymap is triggered
- `vim.lsp.buf.format` (line 200): Function reference
- `require("mason").setup()` (line 184): Immediate function call with `()`

Understanding the difference is crucial: references are passed to be called later, while calls execute immediately.

---

## Summary

This init.lua demonstrates modern Neovim configuration patterns:
- Use `vim.opt` for options (replaces `:set`)
- Use `vim.keymap.set()` for keymaps (replaces `:map` commands)
- Use `vim.pack.add()` for plugin management (Neovim 0.10+)
- Use `require()` for loading Lua modules
- Use `setup()` functions for plugin configuration
- Use LSP for language-specific IDE features

All of these APIs are part of Neovim's Lua interface, which is more powerful and flexible than traditional Vimscript.

For more information, see:
- `:help lua-guide` - Neovim Lua guide
- `:help vim.opt` - Option management
- `:help vim.keymap` - Keymap API
- `:help lsp` - LSP documentation
- `:help vim.diagnostic` - Diagnostic system
