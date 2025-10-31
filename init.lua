-- INFO: options

-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true color support
vim.opt.termguicolors = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Enable line wrapping
vim.opt.wrap = true

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- INFO: colorscheme
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" }, { confirm = false })
vim.cmd.colorscheme("kanagawa")

-- INFO: formatting and syntax highlighting
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")

require("nvim-treesitter.configs").setup({
  sync_install = true,

  modules = {},
  ignore_install = {},

  ensure_installed = {
    "lua",
    "c",
    "rust",
    "go",
  },

  auto_install = true, -- autoinstall languages that are not installed yet

  highlight = {
    enable = true,
  },
})

-- INFO: completion engine
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

require("blink.cmp").setup({
  completion = {
    documentation = {
      auto_show = true,
    },
  },

  sources = {
    default = {
      "lsp",
      "path",
    },
  },

  -- default blink keymaps
  keymap = {
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  fuzzy = {
    implementation = "lua",
  },
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
  lua_ls = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      },
    },
  },
  clangd = {},
  rust_analyzer = {},
  gopls = {},
}

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",                    -- default configs for lsps
  "https://github.com/mason-org/mason.nvim",                     -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim",           -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- :checkhealth vim.lsp. to view default lsp keybindings, use :h lsp-defaults.
for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,

    -- only create the keymaps if the server attaches successfully
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition,
        { buffer = bufnr, desc = "vim.lsp.buf.definition()", })

      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
        { buffer = bufnr, desc = "LSP: [F]ormat Document", })
    end,
  })
end

-- NOTE: if all you want is lsp + completion + highlighting, you're done.
-- the rest of the lines are just quality-of-life plugins and can be removed.
-- To check what clients are attached to the current buffer, use
-- :checkhealth vim.lsp. To view default lsp keybindings, use :h lsp-defaults.

-- INFO: dependencies for other plugins
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons"
}, { confirm = false })

-- INFO: fuzzy finder
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" }, { confirm = false })

require("telescope").setup({})

local pickers = require("telescope.builtin")

vim.keymap.set("n", "<leader>sp", pickers.builtin, { desc = "[S]earch Builtin [P]ickers", })
vim.keymap.set("n", "<leader>sb", pickers.buffers, { desc = "[S]earch [B]uffers", })
vim.keymap.set("n", "<leader>sf", pickers.find_files, { desc = "[S]earch [F]iles", })
vim.keymap.set("n", "<leader>sw", pickers.grep_string, { desc = "[S]earch Current [W]ord", })
vim.keymap.set("n", "<leader>sg", pickers.live_grep, { desc = "[S]earch by [G]rep", })
vim.keymap.set("n", "<leader>sr", pickers.resume, { desc = "[S]earch [R]esume", })

vim.keymap.set("n", "<leader>sh", pickers.help_tags, { desc = "[S]earch [H]elp", })
vim.keymap.set("n", "<leader>sm", pickers.man_pages, { desc = "[S]earch [M]anuals", })

-- INFO File editor
vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })
require('oil').setup()
vim.keymap.set("n", "<leader>o", function() vim.cmd('Oil') end, {desc = "[O]il file editor"})

-- INFO: better statusline
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })

require("lualine").setup({
  options = {
    section_separators = { left = "", right = "", },
    component_separators = { left = "", right = "", },
  },
})

-- INFO: keybinding helper
vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

require("which-key").setup({
  spec = {
    { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green", }, },
  }
})

-- INFO: utility plugins
vim.pack.add({
  "https://github.com/windwp/nvim-autopairs",    -- auto pairs
  "https://github.com/VidocqH/auto-indent.nvim", -- auto indent
  "https://github.com/numToStr/Comment.nvim",    -- gb/gc to (un)comment lines
  "https://github.com/folke/todo-comments.nvim"  -- highlight TODO/INFO/WARN comments
}, { confirm = false })

require("nvim-autopairs").setup()
require("auto-indent").setup()
require("Comment").setup()
require("todo-comments").setup()

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
