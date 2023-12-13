local Terminal  = require('toggleterm.terminal').Terminal
local get = require('toggleterm.config').get

---Creates a terminal for given command and executes it
---@param cmd string
local function create_term(cmd)
	-- Check if toggleterm is there
	-- if not packer_plugins["toggleterm.nvim"] then
	-- 	vim.notify("toggleterm.nvim not installed", vim.log.levels.ERROR)
	-- 	-- vim.cmd([[split term://]]..cmd)
	-- 	-- vim.cmd [[startinsert!]]
	-- 	return
	-- end
	-- if packer_plugins["toggleterm.nvim"].loaded == false then
	-- 	vim.cmd [[ PackerLoad toggleterm.nvim ]]
	-- end
	local repl = Terminal:new({
		cmd = cmd,
		hidden = true,
		close_on_exit = false,
		auto_scroll = true,
		on_open = function (_)
			vim.cmd [[startinsert!]]
		end
	})
	return repl
end

local size_func = get("size")
local direction = get("direction")
local size = size_func({direction = direction})
-- repl:toggle(size, direction)

---Modify cmds replacing the $vars with required things
---@param cmd string
---@param path string
---@return string
local function modify_cmd(cmd, path)
	local normal_cmd = cmd
	cmd = cmd:gsub("$file", vim.fn.fnamemodify(path, ":p"))
	cmd = cmd:gsub("$dir", vim.fn.fnamemodify(path, ":p:h"))
	cmd = cmd:gsub("$fileName", vim.fn.fnamemodify(path, ":t"))
	cmd = cmd:gsub("$fileNameWithoutExt", vim.fn.fnamemodify(path, ":t:r"))
	if normal_cmd == cmd then
		cmd = cmd .. " " .. path
	end
	return cmd
end

local function projects()
end
