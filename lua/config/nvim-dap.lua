-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb
local is_ok, dap = pcall(require, "dap")
if not is_ok then
	return
end

-- https://catppuccin.com/palette
-- https://github.com/mfussenegger/nvim-dap/discussions/355#discussioncomment-4425804
vim.api.nvim_set_hl(0, "dap_red", { fg = "#d20f39" })
vim.api.nvim_set_hl(0, "dap_blue", { fg = "#1e66f5" })
vim.api.nvim_set_hl(0, "dap_green", { fg = "#40a02b" })
vim.api.nvim_set_hl(0, "dap_yellow", { fg = "#df8e1d" })
vim.api.nvim_set_hl(0, "dap_orange", { fg = "#fe640b" })

-- if linehl set to such DapBreakpoint, the text will have color
vim.fn.sign_define("DapBreakpoint", { text = "󰄯", texthl = "dap_orange", linehl = "", numhl = "DapBreakpoint" })
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "󰟃", texthl = "dap_blue", linehl = "", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "dap_red", linehl = "", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "dap_green", linehl = "", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "dap_green", linehl = "", numhl = "DapStopped" })

dap.defaults.fallback.external_terminal = {
	command = "/usr/bin/alacritty",
	args = { "-e" },
}

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-q", "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local gdb_config = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		console = "integratedTerminal",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.cpp = gdb_config
dap.configurations.c = gdb_config
dap.configurations.rust = gdb_config

dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "/usr/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			return "/usr/bin/python"
		end,
	},
}
