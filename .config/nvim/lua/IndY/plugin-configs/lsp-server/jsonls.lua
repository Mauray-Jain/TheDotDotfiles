-- Find more schemas at https://www.schemastore.org/json
local schemas = {
	{
		description = "NPM Configuration File",
		fileMatch = {
			"package.json",
		},
		url = "https://json.schemastore.org/package.json",
	},
	{
		description = "Deno Configuration File",
		fileMatch = {
			"deno.json",
			"deno.jsonc"
		},
		url = require("IndY.functionalities.deno_url_finder")
	},
	{
		description = "Angular Configuration File",
		fileMatch = {"angular.json"},
		url = [[https://raw.githubusercontent.com/angular/angular-cli/master/packages/angular/cli/lib/config/workspace-schema.json]]
	},
	{
		description = "TypeScript Configuration File",
		fileMatch = {
			"tsconfig.json",
			"tsconfig.jsonc"
		},
		url = [[https://json.schemastore.org/tsconfig.json]]
	},
}

local opts = {
	settings = {
		json = {
			schemas = schemas,
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
				end,
			},
		},
	},
}

return opts
