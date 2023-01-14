local keymaps = require("keymaps")
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use {'wbthomason/packer.nvim',opt=true}

	--	input behaviors
	use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup{} end }
	use {'mg979/vim-visual-multi'}
	use { "kylechui/nvim-surround", tag = "*", config = function() require("nvim-surround").setup{} end } -- Use tag="*" for stability; omit to use `main` branch for the latest features

	--	markdown
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', ft = {'markdown'} }
	-- use 'dhruvasagar/vim-table-mode'

	-- insert image 
	--use 'ferrine/md-img-paste.vim'

	-- Lsp config
	use {"williamboman/mason.nvim"}
	use {"williamboman/mason-lspconfig.nvim"}
	use {"neovim/nvim-lspconfig"}
	use {'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-nvim-lsp'}
	use { "ray-x/lsp_signature.nvim" } -- signature hint as you type 
	use {'hrsh7th/cmp-buffer'}
	use {'hrsh7th/cmp-path'}
	use {'rmagatti/goto-preview', config = function() require('goto-preview').setup {} end } --previewing definitions using floating windows. 
	use {'L3MON4D3/LuaSnip'} -- Snippets plugin
	use {'saadparwaiz1/cmp_luasnip'} -- Snippets source for nvim-cmp
	use {'hrsh7th/cmp-nvim-lua', ft={"lua"}} -- plugin to provide vim.api.* completion

----	use {"zbirenbaum/copilot.lua",
----		event = "InsertEnter",
----		config = function ()
----			vim.schedule(function()
----				require("copilot").setup()
----			end)
----		end,
----	}
----	use {"zbirenbaum/copilot-cmp",
----		after = "copilot.lua",
----		config = function()
----			require("copilot_cmp").setup{
----				method = "getCompletionsCycling",
----
----			}
----		end,
----	}

	--for rust, rust-tools 
	--these override the defaults set by rust-tools.nvim
    --	use { "simrat39/rust-tools.nvim", config = { tools = { runnables = { use_telescope = true, }, inlay_hints = { auto = true, show_parameter_hints = false, parameter_hints_prefix = "", other_hints_prefix = "", }, }, } }


	-- dress
	use {'stevearc/dressing.nvim'}


	--	fcitx auto-convertion
	--use {'vim-scripts/fcitx.vim'}
	use {'h-hg/fcitx.nvim'}
	--use '520Matches/fcitx5.vim' 


	-- nvim-R
	use {'jalvesaq/Nvim-R', ft = {'r'}, branch="stable"}

	-- debug 
	use {"ravenxrz/DAPInstall.nvim",opt=true}
	use {"ravenxrz/nvim-dap",opt=true}
	use {"theHamsta/nvim-dap-virtual-text",opt=true}
	use {"rcarriga/nvim-dap-ui",opt=true}

	-- fastfold
	--use {'Konfekt/FastFold', ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'go', 'vim', 'r', 'cs','py','lua'}}
	use {'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		after = "nvim-lspconfig",
		ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'go', 'vim', 'r', 'cs','py','lua'},
		config = function ()
			require("ufo").setup()
		end
	}


	-- a simple tab line
	use {'crispgm/nvim-tabline',
		config = function()
			require('tabline').setup({})
		end,
	}

	-- a fast and easy to config statusline
	use {'nvim-lualine/lualine.nvim',
		event = { "BufRead", "BufNewFile" },
		config = function()
			require('lualine').setup({
				options = {
					component_separators = { left = ' ', right = ' '},
					section_separators = { left = ' ', right = ' '},
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'diagnostics'},
					lualine_c = {'filetype'},
					lualine_x = {'encoding'},
					lualine_y = {'progress'},
					lualine_z = {'location'}
				},
			})
		end,
	}

	-- open ranger in neovim
	use {'kevinhwang91/rnvimr'}

	-- indentLine
	--use {'Yggdroot/indentLine'}
	--use {"lukas-reineke/indent-blankline.nvim", config = function () require("indent_blankline").setup{ } end }

	--fuzzy finder
	use { 'nvim-telescope/telescope.nvim',
		opt=true,
		tag = '0.1.0',
		requires = {'nvim-lua/plenary.nvim'},
		config = function ()
			require("telescopeconfig")
			keymaps.telescopekey()
		end
	}

	-- color theme
	use {'shey-kail/one-nvim'}

	-- start time
	use 'dstein64/vim-startuptime'


end)


