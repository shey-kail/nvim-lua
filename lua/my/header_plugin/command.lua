local fun = require("my.header_plugin.fun")
-- this command is to print the header of csv
vim.api.nvim_create_user_command("Headercsv", function (args)
	fun.header("csv",args.fargs[1],args.fargs[2])
end, {
    desc = "get the header of csv file",
    nargs = "*",
	complete = "file",
})


-- this command is to print the header of tsv
vim.api.nvim_create_user_command("Headertsv", function (args)
	fun.header("tsv",args.fargs[1],args.fargs[2])
end, {
    desc = "get the header of tsv file",
    nargs = "*",
	complete = "file",
})


-- this command is to print the header of csv.gz
vim.api.nvim_create_user_command("Headercsvgz", function (args)
	fun.zheader("csv",args.fargs[1],args.fargs[2])
end, {
    desc = "get the header of csv.gz file",
    nargs = "*",
	complete = "file",
})

-- this command is to print the header of tsv.gz
vim.api.nvim_create_user_command("Headertsvgz", function (args)
	fun.zheader("tsv",args.fargs[1],args.fargs[2])
end, {
    desc = "get the header of tsv.gz file",
    nargs = "*",
	complete = "file",
})
