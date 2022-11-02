require('neorg').setup {
	load = {
		-- The core module to get everything working
		["core.defaults"] = {},
		-- Manage directories full of neorg files
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					["learn-programming"] = "~/repo/Learning-Programming",
				},
			}
		},
		-- Icons > Text
		["core.norg.concealer"] = {},
		-- Auto-completion
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		-- To export to different filetypes
		-- ["core.export"] = {},
		-- Table of Contents
		-- ["core.norg.qol.toc"] = {},
	}
}
