-- Config hacks for Markdown Preview (config is broken in Packer)
-- See: https://github.com/iamcco/markdown-preview.nvim/issues/501
vim.g.mkdp_port = "8800"
vim.g.mkdp_page_title = "${name} - md.nvim"
-- vim.g.mkdp_auto_start = 1
vim.g.mkdp_browser = "brave"
