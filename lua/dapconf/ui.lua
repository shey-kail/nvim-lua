vim.cmd [[packadd nvim-dap]]
vim.cmd [[packadd nvim-dap-ui]]
vim.cmd [[packadd nvim-dap-virtual-text]]

require("dapui").setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "",
	},

	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	layouts = {
		{
			elements = {
				-- Provide as ID strings or tables with "id" and "size" keys
				{
					id = "scopes",
					size = 0.25, -- Can be float or integer > 1
				},
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 40,
			position = "left",
		},
		{ elements = { "repl" }, size = 10, position = "bottom" },
	},
	-- Requires Nvim version >= 0.8
	controls = {
		enabled = true,
		-- Display controls in this session
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "ﱢ",
		},
	},
	floating = {
		max_height = nil,
		max_width = nil,
		mappings = { close = { "q", "<Esc>" } },
	},
	windows = { indent = 1 },
})


vim.api.nvim_command([[packadd nvim-dap-ui]])
local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
	dapui.close()
end

-- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ABE9B3" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "■", texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapStopped",
	{ text = "", texthl = "DapStopped", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "", numhl = "" }
)


require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = true,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

--require("dapconf.language")
