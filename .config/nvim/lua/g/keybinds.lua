local is_vscode = vim.g.vscode ~= nil

-- Stolen from: https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/lua/theprimeagen/keymap.lua
local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

vim.g.mapleader = " " -- Spacebar as leader

local nmap = bind("n", {noremap = false})
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")

-- Hop motion keybinds:
nnoremap('<leader>s', ":HopWordAC<cr>")
nnoremap('<leader>S', ":HopWordBC<cr>")

-- Keep visual selection while indenting:
vnoremap("<", "<gv")
vnoremap(">", ">gv") 

-- Toggle file tree:
if is_vscode then
  nnoremap("<leader>b", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<Cr>")
else
  nnoremap("<leader>b", ":NvimTreeFindFileToggle<cr>")
end

-- Paste without yank in visual mode:
vnoremap("p", '"<leader>_dP')

-- Copy default register to system clipboard:
nnoremap("<leader>y", ':let @+=@\n"')

-- Move lines up and down in visual mode with <Shift>(up/down):
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("<S-Down>", ":m '>+1<CR>gv=gv")
vnoremap("<S-Up>", ":m '<-2<CR>gv=gv")

-- Find things quickly
if is_vscode then
  nnoremap("<leader>ff", "<Cmd>call VSCodeNotify('find-it-faster.findFiles')<Cr>")
  nnoremap("<leader>fg", "<Cmd>call VSCodeNotify('find-it-faster.findWithinFiles')<Cr>")
else
  -- Telescope: https://github.com/nvim-telescope/telescope.nvim#usage
  nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
  nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
  nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
  nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
end

-- Easier split navigation:
if is_vscode then
else
  nnoremap("<M-Left>",  "<C-W>h")
  nnoremap("<M-Down>",  "<C-W>j")
  nnoremap("<M-Up>",    "<C-W>k")
  nnoremap("<M-Right>", "<C-W>l")
  nnoremap("<M-H>", "<C-W>h")
  nnoremap("<M-J>", "<C-W>j")
  nnoremap("<M-K>", "<C-W>k")
  nnoremap("<M-L>", "<C-W>l")
end
