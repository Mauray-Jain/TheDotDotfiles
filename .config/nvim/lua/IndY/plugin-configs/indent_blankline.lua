-- require("indent_blankline").setup {
-- 	space_char_blankline = " ",
-- 	show_current_context = true,
-- 	show_current_context_start = true,
-- 	filetype_exclude = {
-- 		"man",
-- 		"help",
-- 		"lspinfo",
-- 		"packer",
-- 		"TelescopePrompt",
-- 		-- "lsp-installer",
-- 		"TelescopeResults",
-- 		-- "norg",
-- 		-- "",
-- 	},
-- 	buftype_exclude = { "terminal" },
-- }

return {
	indent = {char = "|", tab_char = "|"},
	scope = {show_start = true, show_end = true}
}
