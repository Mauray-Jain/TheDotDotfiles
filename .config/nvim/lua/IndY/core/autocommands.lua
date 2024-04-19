-- Autocommands
local settingsGroup = vim.api.nvim_create_augroup("Settings", {clear = true})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = settingsGroup,
	desc = "Highlight on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "Incsearch",
			timeout = 150,
			on_visual = true,
		})
	end
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = settingsGroup,
-- 	desc = "Set formatoptions",
-- 	pattern = "*",
-- 	callback = function ()
-- 		vim.opt.formatoptions = vim.opt.formatoptions
-- 			- "a"
-- 			+ "t"
-- 			+ "c"
-- 			+ "q"
-- 			+ "/"
-- 			+ "r"
-- 			+ "n"
-- 			+ "j"
-- 			- "2"
-- 	end
-- })

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = settingsGroup,
-- 	desc = "Autocommand that updates, installs and removes plugins whenever you save the plugins.lua file",
-- 	pattern = "plugins.lua",
-- 	command = "Lazy sync"
-- })

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	group = settingsGroup,
-- 	desc = "Autocommand that changes tabstop acc to my likings",
-- 	pattern = "*.py",
-- 	command = "set tabstop=2 shiftwidth=2 noexpandtab softtabstop=0"
-- })
