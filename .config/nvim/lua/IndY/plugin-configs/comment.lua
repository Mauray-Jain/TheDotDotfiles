-- Keybindings
-- C-/ to toggle comment in insert mode
vim.keymap.set("i", "<C-_>", "<Esc><Plug>(comment_toggle_current_linewise)gi")

-- Setup
require('Comment').setup{
	opleader = { -- LHS of Operator pending mode
		line = "gc",
		block = "gb"
	},
	toggler = { -- Toggle mapping LHS
		line = "gcc",
		block = "gbc"
	},
	mappings = {
		-- Basic mappings like gc[count]{motion} and gb[count]{motion} and ofc gcc and gbc
		basic = true,
		-- Extra mappings like gco, gcO, gcA
		extra = true,
	},
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	-- Ignore certain lines can be Lua regex or a fun() that returns that
	ignore = "^$", -- Ignoring empty lines
}
