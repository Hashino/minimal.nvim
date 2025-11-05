vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config({ virtual_text = true })

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
}, { confirm = false })

require("nvim-treesitter.install").update("all")
require("nvim-treesitter.configs").setup({ auto_install = true })
require("blink.cmp").setup({ fuzzy = { implementation = "lua" } })

local lsp_servers = {
  lua_ls = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } }, },
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,

    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = bufnr })
    end,
  })
end
