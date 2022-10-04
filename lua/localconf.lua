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
--- === change color
--- ===
---change popup menu's color
--vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#BBBBBB', bg = '#272727' })
--vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#BBBBBB', bg = '#004b72' })
--vim.api.nvim_set_hl(0, 'PmenuSbar', { fg = 'NONE', bg = '#343B41' })
--vim.api.nvim_set_hl(0, 'PmenuThumb', { fg = 'NONE', bg = '#BBBBBB' })
--
-----change tab line's color
--vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#BBBBBB', bg = '#272727' })
--vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#BBBBBB', bg = '#272727' })
--
-----change status line's color
----setting tab line's background color
--vim.api.nvim_set_hl(0, 'TabLineFill', { fg = "NONE", bg = '#272727' })
----setting unselected tab's color
--vim.api.nvim_set_hl(0, 'TabLine', { fg = "NONE", bg = "#272727" })
----setting selected tab's color
--vim.api.nvim_set_hl(0, 'TabLineSel', { fg = "NONE", bg = "#777777" })
--
----setting WinSeparator color
--vim.api.nvim_set_hl(0, 'WinSeparator', { fg = "NONE", bg = "#272727" })

--setting SignColumn color
--vim.api.nvim_set_hl(0, 'SignColumn', { fg = "NONE", bg = "#000000" })

