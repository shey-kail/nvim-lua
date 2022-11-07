vim.o.number = true
vim.o.showmatch = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.ignorecase = true
vim.o.encoding = "utf-8"    -- 保存时的字符编码
vim.o.fileencodings = "ucs-bom,utf-8,cp936"  -- 字符编码
vim.opt.signcolumn = "yes"   -- 总是显示最左边的signcolumn

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
--- === disable default keymaps of Nvim-R, I have set some keymaps in keymaps.lua
--- ===
vim.g.R_user_maps_only = 1
vim.g.R_assign = 0
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	  pattern = {"*.r", "*.R"},
	  callback = require("keymaps").nvimRkey
})

