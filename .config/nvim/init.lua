-- Commands
if vim.fn.has("wsl") then
	vim.api.nvim_create_user_command("Clipboard", function (_)
		vim.fn.system("clip.exe", vim.fn.getreg('"'))
	end, {})
end

require("IndY.plugins")
require("IndY.core")
