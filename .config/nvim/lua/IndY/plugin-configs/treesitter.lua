-- TreeSitter Setup
return {
	sync_install = false,
	auto_install = false,
	init = function()
		vim.api.nvim_create_autocmd('FileType', {
			callback = function()
				-- Enable treesitter highlighting and disable regex syntax
				pcall(vim.treesitter.start)
				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
		local ensure_installed = {
			"bash",
			"c",
			-- "c_sharp",
			"cpp",
			"css",
			-- "dart",
			"go",
			"html",
			-- "http",
			-- "java",
			"javascript",
			"jsdoc",
			"json",
			-- "json5",
			-- "jsonc",
			-- "kotlin",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"norg",
			"ocaml",
			-- "php",
			-- "pug",
			"python",
			"rust",
			"scheme",
			-- "toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			-- "vue",
			"zig",
		}
		local alreadyInstalled = require('nvim-treesitter.config').get_installed()
		local parsersToInstall = vim.iter(ensure_installed)
		:filter(function(parser)
			return not vim.tbl_contains(alreadyInstalled, parser)
		end)
		:totable()
		require('nvim-treesitter').install(parsersToInstall)
	end,
	-- ignore_install = {"vim"},
	-- Nvim-Autopairs
	-- autopairs = {
	-- 	enable = true
	-- },
	-- Textobjects
	-- textobjects = {
	-- 	select = { -- Similar to ap and ip
	-- 		enable = true,
	-- 		lookahead = true, -- Always jump to next
	-- 		keymaps = {
	-- 			["if"] = "@function.inner",
	-- 			["af"] = "@function.outer",
	-- 			["ic"] = "@class.inner",
	-- 			["ac"] = "@class.outer",
	-- 		},
	-- 	},
	-- },
}
