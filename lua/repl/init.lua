local iron = require("iron.core")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
		python = {command = function ()
			if os.getenv("CONDA_PREFIX") == nil then
				return {"ipython3"}
			else
				return {os.getenv("CONDA_PREFIX") .. "/bin/ipython3"}
			end
		end };
		r = {command = function ()
			if os.getenv("CONDA_PREFIX") == nil then
				return {"R"}
			else
				return {os.getenv("CONDA_PREFIX") .. "/bin/rstudio"}
			end
		end }
    },
    repl_open_cmd = 'rightbelow 40vsplit',
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
	visual_send = "<localleader><leader>",
	send_line   = "<localleader><leader>",
	clear       = "<localleader>cl",

  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = false, -- ignore blank lines when sending visual select lines
}

