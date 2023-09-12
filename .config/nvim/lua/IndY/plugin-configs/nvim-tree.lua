-- Setup
require("nvim-tree").setup {
	disable_netrw = true,
	hijack_cursor = true,
	hijack_netrw = true,
	open_on_tab = false,
	sort_by = "name",
	view = {
		--[[ height = 30, ]]
		side = "right",
		signcolumn = "yes",
	},
	renderer = {
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				bottom = "─",
				none = "  ",
			},
		},
	},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
}
