local picker = require("telescopeconfig.picker")
local preview = require("telescopeconfig.preview")


require("telescope").setup {
	defaults = {
		buffer_previewer_maker = preview.new_maker,
		vimgrep_arguments = picker.vimgrep_arguments,
	},
	pickers = picker.pickers

}
