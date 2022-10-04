
local M = {}


---
--- this function is to print the header of csv or tsv
---
M.header = function(f_type, file, range)
	range = range or ""
	local tbl

	if range=="" then
		tbl={"r! head -1 ", file}
	else
		if f_type=="tsv" then
			tbl={"r! head -1 ", file, " | cut -f ", range}
		elseif f_type=="csv" then
			tbl={"r! head -1 ", file, " | cut -d, -f ", range}
		end
	end
	vim.cmd(table.concat(tbl))
end



---
--- this function is to print the header of csv.gz or tsv.gz
---
M.zheader = function(f_type, file, range)
	range = range or ""
	local tbl

	if range=="" then
		tbl={"r! zcat ",file," | head -1 "}
	else
		if f_type=="tsv" then
			tbl={"r! zcat ",file," | head -1 ", " | cut -f ", range}
		elseif f_type=="csv" then
			tbl={"r! zcat ",file," | head -1 ", " | cut -d, -f ", range}
		end
	end
	vim.cmd(table.concat(tbl))
end

return M
