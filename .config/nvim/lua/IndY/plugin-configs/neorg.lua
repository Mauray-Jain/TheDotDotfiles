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
					d2 = "~/repo/datu-de-noteaiss/",
					resources = "~/repo/Learning-Programming/Resources",
				},
			},
		},
		["core.looking-glass"] = {},
		["core.export"] = {},
		["core.completion"] = {
			config = {
				engine = { module_name = "external.lsp-completion" },
			},
		},
		["external.interim-ls"] = {},
	},
}
