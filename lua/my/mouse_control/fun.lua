
local M = {}

---
--- this function is enable mouse or disable mouse in neovim
---
M.mouse_control = function(command)
	if command == "enable" then
		vim.o.mouse = "a"
	elseif command == "disable" then
		vim.o.mouse = ""
	end
end


return M
