local keymaps = require("keymaps")
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd plenary.nvim]]
vim.cmd [[packadd telescope.nvim]]
vim.cmd [[packadd nui.nvim]]

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
					r =true
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

	use {"jackMort/ChatGPT.nvim",
		opt = true,
		config = function()
			require("chatgpt").setup({
			  welcome_message = "欢迎回来，沙福林大人", -- set to "" if you don't like the fancy godot robot
			  loading_text = "loading",
			  question_sign = "😈", -- you can use emoji if you want e.g. 🙂
			  answer_sign = "🤖", -- 🤖
			  max_line_length = 120,
			  yank_register = "+",
			  chat_layout = {
				relative = "editor",
				position = "50%",
				size = {
				  height = "80%",
				  width = "80%",
				},
			  },
			  settings_window = {
				border = {
				  style = "rounded",
				  text = {
					top = " Settings ",
				  },
				},
			  },
			  chat_window = {
				filetype = "chatgpt",
				border = {
				  highlight = "FloatBorder",
				  style = "rounded",
				  text = {
					top = " ChatGPT ",
				  },
				},
			  },
			  chat_input = {
				prompt = "  ",
				border = {
				  highlight = "FloatBorder",
				  style = "rounded",
				  text = {
					top_align = "center",
					top = " Prompt ",
				  },
				},
			  },
			  openai_params = {
				model = "text-davinci-003",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 300,
				temperature = 0,
				top_p = 1,
				n = 1,
			  },
			  openai_edit_params = {
				model = "code-davinci-edit-001",
				temperature = 0,
				top_p = 1,
				n = 1,
			  },
			  keymaps = {
				close = { "<Esc>" },
				yank_last = "<C-y>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				toggle_settings = "<C-o>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
			  },


			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	}

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


