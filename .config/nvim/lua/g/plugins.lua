local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer should be first:
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			local project_actions = require("telescope._extensions.project.actions")
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
						vertical = {
							mirror = true,
						},
					},
					mappings = require("g/keybinds").telescope.defaults,
				},
				extensions = {
					project = {
						on_project_selected = function(prompt_bufnr)
							project_actions.change_working_directory(prompt_bufnr, false)
							-- TODO: this is broken if a session does not exist
							-- for the project because a buffer/file is never loaded.
							-- Need to check that a file has been loaded before doing
							-- the edit command.
							vim.cmd("e") -- make sure filetype is detected
						end,
					},
				},
			})
			require("telescope").load_extension("project")
		end,
	})

	use({
		"~/src/github.com/gerryhernandez/telescope-project.nvim",
		--"nvim-telescope/telescope-project.nvim",
	})

	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "/", "~/" },
				cwd_change_handling = {
					auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
					restore_upcoming_session = true,
					pre_cwd_changed_hook = function() end,
					post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
					end,
				},
			})
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
		end,
	})

	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup({})
		end,
	})

	-- Color Schemes:
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("Mofiqul/dracula.nvim")
	use("folke/tokyonight.nvim")
	use("marko-cerovac/material.nvim")
	use("shaunsingh/moonlight.nvim")
	use("yashguptaz/calvera-dark.nvim")
	use("tiagovla/tokyodark.nvim")
	use("kartikp10/noctis.nvim")

	-- Motion:
	use("ggandor/leap.nvim")

	-- Status line:
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup()
		end,
	})

	-- Buffer line:
	-- using packer.nvim
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- File manager:
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				on_attach = function(bufnr)
					require("g/keybinds").apply_nvim_tree(bufnr)
				end,
			})
		end,
	})

	-- Markdown Utils:
	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

  -- Obsidian notes integration:
  use({
    "~/src/github.com/gerryhernandez/obsidian.nvim",
    --"epwalsh/obsidian.nvim",
    config = function()
      require("obsidian").setup({
        use_advanced_uri = true,
        dir = "~/notes/Brain",
        daily_notes = {
          folder = "dailies",
        },
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
        note_id_func = function(title)
          return title
        end,
      })
    end,
  })

	--  use({
	--    'euclio/vim-markdown-composer',
	--    run = 'cargo build --release',
	--    config = function ()
	--      vim.g.markdown_composer_external_renderer='pandoc -f markdown -t html'
	--      vim.g.markdown_composer_autostart = 0
	--    end
	--  })

	-- Other niceties:

	-- Use NeoVim as a text editor for text fields within Firefox:
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	-- Shows available options for leader keys:
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	-- Auto pairs, as the name implies:
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")

	use("folke/trouble.nvim")

	-- Shows Git line status (changes, etc) in the gutter ("signs" column):
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Language Tools:

	use({
		"nvim-treesitter/nvim-treesitter",
		-- commit = "fd4525fd9e61950520cea4737abc1800ad4aabb",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "rust", "go", "markdown", "markdown_inline" },
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
			})
		end,
	})
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "williamboman/mason-lspconfig.nvim" })
	-- use({'jayp0521/mason-nvim-dap.nvim'})
	-- Adds extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")
	-- "Internal" package management, useful for installing LSPs, DAP, etc:
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			-- require("mason-nvim-dap").setup({
			--   automatic_setup = true,
			--   automatic_installation = true,
			--   ensure_installed = {'delve'}
			-- })
		end,
	})

	-- Debugging
	use({ "mfussenegger/nvim-dap" })
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	})
	use({
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
