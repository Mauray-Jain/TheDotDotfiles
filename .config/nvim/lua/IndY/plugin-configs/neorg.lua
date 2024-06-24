return {
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = { -- Adds pretty icons to your documents
			config = {
				icons = {
					todo = {
						urgent = { icon = "" },
					},
				},
			},
		},
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					notes = "~/notes",
					resources = "~/repo/Learning-Programming/Resources",
				},
			},
		},
	},
}
