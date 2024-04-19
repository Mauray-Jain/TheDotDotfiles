-- TreeSitter Setup
return {
	ensure_installed = {
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
		-- "norg",
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
	},
	sync_install = false,
	auto_install = false,
	-- ignore_install = {"vim"},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	-- Indent with = based on treesitter
	indent = {
		enable = true,
	},
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
