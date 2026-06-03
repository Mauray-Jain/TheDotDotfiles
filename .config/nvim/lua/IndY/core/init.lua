require("IndY.core.mappings")
require("IndY.core.options")
require("IndY.core.autocommands")

-- Statusline
require("IndY.core.statusline")
vim.opt.statusline = "%{%v:lua.Statusline()%}"
