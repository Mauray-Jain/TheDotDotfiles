require("IndY.core.mappings")
require("IndY.core.options")
require("IndY.core.autocommands")
require("IndY.core.lsp")
require("IndY.core.treesitter")

-- Statusline
require("IndY.core.statusline")
vim.opt.statusline = "%{%v:lua.Statusline()%}"
