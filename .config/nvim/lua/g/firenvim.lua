-- if not vim.g.started_by_firenvim then
--   return
-- end

vim.g.firenvim_config = {
	globalSettings = {},
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			takeover = "never",
		},
	},
}

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "FireNvim BufEnter",
	callback = function()
		if not vim.g.started_by_firenvim then
			return
		end
		vim.opt.laststatus = 0
		require("g/keybinds").apply_firenvim()
	end,
})
