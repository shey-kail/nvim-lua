local previewers = require("telescope.previewers")


 -- Disable highlighting for these file. Put all filetypes that slow you down in this array. 
local _bad = { ".*%.csv", ".*%.txt", ".*%.bed", ".*%.fa", ".*%.fasta", ".*%.fastq", ".*%.fq", ".*%.sam"}
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end
  return true
end

local M = {}
M.new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
	-- if file size is larger than 100000, it will disable previewer for this file
    if not stat then return end
    if stat.size > 100000 then
      return
	-- if file size is less than 100000, previewer will work normally. if the type of these file is in the list of _bad, highlighting will disable for them.
    else if opts.use_ft_detect == nil then opts.use_ft_detect = true end
	  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
	  previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

return M
