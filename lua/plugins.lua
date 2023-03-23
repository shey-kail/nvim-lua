--local keymaps = require("keymaps")
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd plenary.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use {'wbthomason/packer.nvim',opt=true}

	--	input behaviors
	use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup{} end }
	use {'mg979/vim-visual-multi'}
	use { "kylechui/nvim-surround", tag = "*", config = function() require("nvim-surround").setup{} end } -- Use tag="*" for stability; omit to use `main` branch for the latest features

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

	use {'L3MON4D3/LuaSnip',
		config = function ()
			local snippet_path = os.getenv("HOME") .. "/.config/nvim/snippets/"
			if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
				vim.opt.rtp:append(snippet_path)
			end

			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				delete_check_events = "TextChanged,InsertLeave",
			})
			require("luasnip.loaders.from_lua").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end} -- Snippets plugin

	use {'saadparwaiz1/cmp_luasnip'} -- Snippets source for nvim-cmp
	use {'hrsh7th/cmp-nvim-lua', ft={"lua"}} -- plugin to provide vim.api.* completion

	use {"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function ()
			vim.schedule(function()
				require("copilot").setup({
				  suggestion = { enabled = false },
				  panel = { enabled = false },
				  filetypes = {
					sh = true,
					py = true,
					go = true,
					lua = true,
					r = true
				  },
				})

			end)
		end,
	}

	use {"zbirenbaum/copilot-cmp",
		after = "copilot.lua",
		config = function()
			require("copilot_cmp").setup{
				method = "getCompletionsCycling",
			}
		end,
	}

	-- dress
	use {'stevearc/dressing.nvim'}

	--	fcitx auto-convertion
	use 'h-hg/fcitx.nvim'

	-- nvim-R
	use {'jalvesaq/Nvim-R', ft = {'r'}, branch="stable" }

	-- debug 
	use {"ravenxrz/DAPInstall.nvim",opt=true}
	use {"ravenxrz/nvim-dap",opt=true}
	use {"theHamsta/nvim-dap-virtual-text",opt=true}
	use {"rcarriga/nvim-dap-ui",opt=true}
    use {'hkupty/iron.nvim'}


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
	use {'is0n/fm-nvim',
		config = require('fm-nvim').setup{
			-- (Vim) Command used to open files
			edit_cmd = "edit",
			-- See `Q&A` for more info
			-- on_close = {},
			-- on_open = {},
			-- Terminal commands used w/ file manager (have to be in your $PATH)
			cmds = {
				gitui_cmd   = "gitui",
				ranger_cmd  = "ranger",
				joshuto_cmd = "joshuto",
			},
			-- Mappings used with the plugin
			mappings = {
				vert_split = "<C-v>",
				horz_split = "<C-h>",
				tabedit    = "<C-t>",
				edit       = "<C-e>",
				ESC        = "<ESC>"
			},
			-- Path to broot config
			broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson"
		}
	}

	--fuzzy finder
	use {'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} } }

	-- color theme
	use {'shey-kail/one-nvim'}

	-- start time
	use 'dstein64/vim-startuptime'

	-- indentLine
	--use {'Yggdroot/indentLine'}
	--use {"lukas-reineke/indent-blankline.nvim", config = function () require("indent_blankline").setup{ } end }


end)


