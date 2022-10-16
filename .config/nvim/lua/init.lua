-- Load plugins so they can be configured:
require('g/plugins')

-- NvimTree (needs to be early in config):
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Basic settings:
require('g/basic_settings')

-- Initialize customized color schemes so when we switch to them, they're the 
-- way I like them:
require('g/colors/dracula')
require('g/colors/material')
vim.cmd[[colorscheme dracula]]

-- Init LuaLine status line:
-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
require('lualine').setup()

-- Telescope
require('g/telescope')

-- Load custom keybinds
require('g/keybinds')

-- Load LSP config
require('g/lsp')

