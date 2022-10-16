vim.opt.nu = true             -- Show line number on current line
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 20
vim.opt.colorcolumn = "80"    -- Column border

vim.cmd[[
" Basic Vim settings (haven't yet ported to lua):

set timeoutlen=500          " Set timeout length to 500 ms
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching braces
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set mouse=a                 " enable mouse click
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
filetype plugin on
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set splitbelow splitright   " default split location

" Support for true color:
if $TERM !=? 'xterm-256color'
  set termguicolors
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Have a transparent background:
" augroup user_colors
"   autocmd!
"   autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
" augroup END
]]


