vim.o.number = true
vim.o.showmatch = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.encoding = "utf-8"    -- 保存时的字符编码
vim.o.fileencodings = "ucs-bom,utf-8,cp936"  -- 字符编码
vim.opt.signcolumn = "yes"   -- 总是显示最左边的signcolumn
vim.o.mouse = "" --禁用鼠标

--vim.o.clipboard = "unnamedplus" --打通剪贴板

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.autoindent = true     --自动缩进
vim.o.smartindent = true     --智能缩进

--- ===
--- === set <TAB>'s width as 4 spaces 
--- ===
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

--- ===
--- === set colorscheme to one-nvim
--- ===
-- before setting colorscheme, setting whole background to be transparent
vim.g.one_nvim_transparent_bg = true
vim.cmd("colorscheme one-nvim")

--- ===
--- === nvim-r
--- ===
--autostart R when editing an R file
vim.g.R_auto_start = 1
--do not see R documentation in a vim buffer
--vim.g.R_nvimpager='no'
-- disable default keymaps of Nvim-R, I have set some keymaps in keymaps.lua
vim.g.R_user_maps_only = 1
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	  pattern = {"*.r", "*.R"},
	  callback = require("keymaps").nvimRkey
})
-- disable convertion from "_" into "<-"
vim.g.R_assign = 0
-- args when starting R
vim.g.R_args = {"--no-save","--quiet"}
-- View a data.frame or matrix
vim.g.R_df_viewer = "View(%s)"

