local vim = vim
vim.cmd [[packadd DAPInstall.nvim]]
local dap_install = require("dap-install")

-- python
local py_dbg_path = require("dap-install.config.settings").options["installation_path"] .. "python/bin/python3"

local get_conda_py = function ()
	if os.getenv("CONDA_PREFIX") == nil then
		return ""
	else
		return os.getenv("CONDA_PREFIX") .. "/bin/python3"
	end
end

dap_install.config(
	"python",
    {
        adapters = {
            type = "executable",
            command = py_dbg_path,
            args = {"-m", "debugpy.adapter"}
        },
        configurations = {
            {
                type = "python",
                request = "launch",
                name = "Launch debugpy",
                program = "${file}",
                args = function()
                  local input = vim.fn.input("Input args: ")
                  return require("dapconf.util").str2argtable(input)
                end,
				-- the python path to run script rather than debugpy
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
					local conda_py = get_conda_py()

					if vim.fn.executable(cwd .. '/env/bin/python') == 1 then
						return cwd .. '/env/bin/python'
					elseif vim.fn.executable(cwd .. '/.env/bin/python') == 1 then
						return cwd .. '/.env/bin/python'
					elseif vim.fn.executable(conda_py) == 1 then
						return conda_py
					else
						return '/usr/bin/python3'
					end

                end
            }
        }
    }
)


--golang
dap_install.config(
  "go_delve",
  {
		configurations = {
			{
			  type = "go",
			  name = "Launch go debug",
			  request = "launch",
			  cwd = '${workspaceFolder}',
			  program = "${file}",
			  args = function()
			    local input = vim.fn.input("Input args: ")
			    return require("user.dap.dap-util").str2argtable(input)
			  end,
			},
			{
			  type = "go",
			  name = "Debug test", -- configuration for debugging test files
			  request = "launch",
			  mode = "test",
			  cwd = '${workspaceFolder}',
			  program = "${file}"
			},
			-- works with go.mod packages and sub packages
			{
			  type = "go",
			  name = "Debug test (go.mod)",
			  request = "launch",
			  mode = "test",
			  cwd = '${workspaceFolder}',
			  program = "./${relativeFileDirname}"
			},
		}
  }
)


--rust
dap_install.config(
  "codelldb",
  {}
)

