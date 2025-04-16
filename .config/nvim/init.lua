require("IndY.core.mappings")
require("IndY.core.options")
require("IndY.core.autocommands")

-- Commands
if vim.fn.has("wsl") then
	vim.api.nvim_create_user_command("Clipboard", function (_)
		vim.fn.system("clip.exe", vim.fn.getreg('"'))
	end, {})
end

require("IndY.plugins")
require("IndY.core.lsp")

-- Statusline
require("IndY.core.statusline")
vim.opt.statusline = "%{%v:lua.Statusline()%}"
