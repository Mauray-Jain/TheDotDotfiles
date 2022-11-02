-- Courtesy: https://elianiva.my.id/post/neovim-lua-statusline
-- Some Aliases
local cmd = vim.cmd
local icons_status, icons = pcall(require, "nvim-web-devicons")
-- Palette of colours
local palette = {
	oldWhite = "#C8C093",
	crystalBlue = "#7E9CD8",
	lightBlue = "#A3D4D5",
	boatYellow1 = "#938056"
}
local tables = require("IndY.statusline.helper_tables")
local modes = tables.modes
local trunc_width = tables.truncating_width
local M = {}

M.makeFTSection = function()
	return "%f"
end

-- Helper Functions
local function highlight(group, fg, bg)
	cmd("highlight " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
end

highlight("StatusMidFT", palette.boatYellow1, palette.crystalBlue)

M.is_truncated = function(width)
	local current_width = vim.api.nvim_win_get_width(0)
	return current_width < width
end

M.mode_comp = function ()
	local current_mode = vim.api.nvim_get_mode().mode
	if M.is_truncated(trunc_width.mode) then
		return string.format("%s", modes[current_mode][2])
	end
	return string.format("%s", modes[current_mode][1])
end

-- Making the status line dynamically
-- Inactive statusline won't be needed due to the new feature of global statusline
function Status_line()
	return table.concat {
		M.mode_comp()
	}
end

vim.opt.statusline = "%!luaeval('Status_line()')"
