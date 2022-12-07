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

-- Disable netrw to avoid conflict with nvim-tree:
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local set = vim.opt

set.nu = true -- Show line number on current line
set.relativenumber = true -- Show relative line numbers

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true
set.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
set.autoindent = true -- maintain indent of current line

set.scrolloff = 20
set.colorcolumn = "80" -- Column border
set.sidescrolloff = 4

set.undofile = true
set.undodir = vim.fn.stdpath("config") .. "/undo"
set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.incsearch = true -- incremental search
set.hlsearch = true -- highlighted search results
set.ignorecase = true -- ignore case sensetive while searching
set.smartcase = true
set.mouse = "a" -- turn on mouse interaction
set.updatetime = 500 -- CursorHold interval
set.shiftround = true
set.splitbelow = true -- open horizontal splits below current window
set.splitright = true -- open vertical splits to the right of the current window

set.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
set.inccommand = "split" -- live preview of :s results

-- Initialize customized color schemes so when we switch to them, they're the
-- way I like them:
require("g/colors/dracula")
require("g/colors/material")
vim.cmd([[colorscheme tokyonight-night]])
