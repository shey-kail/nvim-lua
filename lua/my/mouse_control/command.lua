local fun = require("my.mouse_control.fun")

-- create "mouse" command is to enable or disable mouse in neovim
-- if "mouse" command's arg is "enable", then call fun.mouse_control("e")
-- if "mouse" command's arg is "disable", then call fun.mouse_control("d")
-- complete information is "enable" or "disable"
vim.api.nvim_create_user_command("Mouse", function (args)
	if args.fargs[1] ~= "enable" and args.fargs[1] ~= "disable" then
		error("'Mouse' command's arg must be enable or disable")
	else
		fun.mouse_control(args.fargs[1])
	end
end, {
	desc = "enable or disable mouse in neovim",
	nargs = 1,
	complete = "customlist,v:lua.my_completion_function"
})

function _G.my_completion_function(arg_lead, cmd_line, cursor_pos)
  local candidates = {"enable", "disable"}
  --如果有输入，则根据输入对候选参数进行筛选
  return vim.tbl_filter(function (c) return string.find(c, arg_lead, 1, true) end, candidates)
end
