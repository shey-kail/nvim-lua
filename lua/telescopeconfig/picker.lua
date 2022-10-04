
local M = {}

M.pickers = {
	find_files = {
		mappings = {
			-- enable cd in telescope
			n = {
				["cd"] = function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry()
					local dir = vim.fn.fnamemodify(selection.path, ":p:h")
					require("telescope.actions").close(prompt_bufnr)
					-- Depending on what you want put `cd`, `lcd`, `tcd`
					vim.cmd(string.format("silent lcd %s", dir))
				end
			},
		},
		-- enable find hidden files (exclude .git)
		find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
	},
}
M.vimgrep_arguments = {
		"rg",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
		"--trim" -- To trim the indentation at the beginning of presented line in the result window
}

return M
