# INTRODUCTION:

this is a minimal neovim configuration written in lua. this is not meant to
be a distribution, but rather a template for you to build upon and/or a
reference for how to configure neovim using lua in the latest version.

# TUTOR:

if you're completely new to neovim and/or vim, consider going through
`:Tutor` inside neovim to get a basic idea of how it works.
    if you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

# LUA:

some level of familiarity with lua/programming languages are also expected.
if you're new to lua, consider going through the official reference:
   https://www.lua.org/manual
or a more friendly tutorial like:
   https://learnxinyminutes.com/docs/lua/
you can also check out `:h lua-guide` inside neovim for a neovim-specific
lua guide.

# DEPENDENCIES:

this configuration assumes you have the following tools installed on your
system:
   `git` - for vim builtin package manager. (see `:h vim.pack`)
   `unzip` - for mason, specifically for `clangd`, which the config installs by default
   `ripgrep` - for fuzzy finding
   clipboard tool: xclip/xsel/win32yank - for clipboard sharing between OS and neovim (see `h: clipboard-tool`)
   a nerdfont (ensure the terminal running neovim is using it)
run `:checkhealth` inside neovim to see if your system is missing anything.

# MINIMAL:

to say that something is 'minimal' you have to define what variable you're
minimizing. this configuration minimizes for lines of code and concepts. to
some, this configuration may have too many plugins. for example, using
mason.nvim to manage lsp servers will be an unnecessary dependency if the user
is already familiar with lsps and is comfortable managing them through their OS
package manager. but to someone that isn't familiar with lsp servers this
approach wouldn't cover everything needed to have the 'minimum' necessary for
lsp + completion + fuzzy finding. to some, fuzzy finding is also a bloated
dependency.
this configuration is only a starting point/reference. it is expected that
the user will change the configuration to suit their needs.

# OPTIONS:

these change the default neovim behaviours using the 'vim.opt' API.
see `:h vim.opt` for more details.
run `:h '{option_name}'` to see what they do and what values they can take.
for example, `:h 'number'` for `vim.opt.number`.

# PLUGINS

we install plugins with neovim's builtin package manager: vim.pack
and then enable/configure them by calling their setup functions.

(see `:h vim.pack` for more details on how it works)
you can press `gx` on any of the plugin urls below to open them in your
browser and check out their documentation and functionality.
alternatively, you can run `:h {plugin-name}` to read their documentation.

plugins are then loaded and configured with a call to `setup` functions
provided by each plugin. this is not a rule of neovim but rather a convention
followed by the community.
these setup calls take a table as an agument and their expected contents can
vary wildly. refer to each plugin's documentation for details.
