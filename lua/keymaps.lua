-- the function map(mode, lhs, rhs, opts)
-- {mode}  Mode short-name (map command prefix: "n", "i", "v", "x", …) or "!" for |:map!|, or empty string for |:map|.
-- {lhs}   Left-hand-side |{lhs}| of the mapping.
-- {rhs}   Right-hand-side |{rhs}| of the mapping.
-- {opts}  Optional parameters map. Accepts all |:map-arguments| as keys excluding |<buffer>| but including |noremap| and "desc". "desc" can be used to give a description to keymap. When called from Lua, also accepts a "callback" key that takes a Lua function to call when the mapping is executed. Values are Booleans. Unknown key is an error.
local function noremap(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end


-- the function map(mode, lhs, rhs, opts)
-- {mode}  Mode short-name (map command prefix: "n", "i", "v", "x", …) or "!" for |:map!|, or empty string for |:map|.
-- {lhs}   Left-hand-side |{lhs}| of the mapping.
-- {rhs}   Right-hand-side |{rhs}| of the mapping.
-- {opts}  Optional parameters map. Accepts all |:map-arguments| as keys excluding |<buffer>| but including |noremap| and "desc". "desc" can be used to give a description to keymap. When called from Lua, also accepts a "callback" key that takes a Lua function to call when the mapping is executed. Values are Booleans. Unknown key is an error.
local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end


--- simple note: 
--- noremap("i","...","...","...") equals to inoremap
--- noremap("n","...","...","...") equals to nnoremap
--- etc

-- ===
-- === Remap space as leader key
-- ===
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ===
-- === open init.vim file anytime
-- ===
noremap('n', '<leader>rc', '<cmd>tabedit ~/.config/nvim/init.lua<CR>', {})
-- Quickly edit the configuration
noremap('n', '<leader>fs', '<cmd>tabedit ~/.config/nvim/lua/plugins.lua<cr>', {})

-- ===
-- === windows management
-- ===
-- use <space> + hjkl for moving the cursor around windows
noremap('n', '<leader>w', '<C-w>w', {})
noremap('n', '<leader>k', '<C-w>k', {})
noremap('n', '<leader>h', '<C-w>h', {})
noremap('n', '<leader>j', '<C-w>j', {})
noremap('n', '<leader>l', '<C-w>l', {})
-- resize splits with arrow keys
noremap('n', '<up>', ':res +5<CR>', {})
noremap('n', '<down>', ':res -5<CR>', {})
noremap('n', '<left>', ':vertical resize-5<CR>', {})
noremap('n', '<right>', ':vertical resize+5<CR>', {})


--use Ctrl+jk for repaid warching 
noremap('n', '<C-j>', '5j', {})
noremap('n', '<C-k>', '5k', {})


--use alt+o to add a new line down
noremap('i', '<A-o>', '<Esc>o', {})
--use alt+O to add a new line up
noremap('i', '<A-O>', '<Esc>O', {})
--use <Esc> to exit terminal-mode
noremap('t', '<Esc>', '<C-\\><C-n>', {})
-- <leader>ra to start RnvimrToggle
noremap('n', '<leader>ra', '<cmd>RnvimrToggle<cr>', {})


-- telescope keymaps
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, {})
map('n', '<leader>fg', telescope.live_grep, {})
map('n', '<leader>b', telescope.buffers, {})
map('n', '<leader>h', telescope.help_tags, {})



---
---lsp attach function : mapping keys
---
local M = {}
M.attach = function(client, bufnr) -- set up buffer keymaps, etc.

	local bufopts = {silent=true, buffer=bufnr }
	local gp=require('goto-preview')
	noremap('n', '<leader>gd', gp.goto_preview_definition, bufopts)
	noremap('n', '<leader>gt', gp.goto_preview_type_definition, bufopts)
	noremap('n', '<leader>gr', gp.goto_preview_references, bufopts)
	noremap('n', '<leader>gi', gp.goto_preview_implementation, bufopts)
	noremap('n', '<leader>gx', gp.close_all_win, bufopts)
--nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>


	noremap('n', 'K', vim.lsp.buf.hover, bufopts)
	noremap('n', '<space>rn', vim.lsp.buf.rename, bufopts)

end

return M



