-- -- Install lazy if not already present
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable", -- latest stable release
-- 		lazypath,
-- 	})
-- end
-- vim.opt.rtp:prepend(lazypath)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Spec
local plugins = {
	{ -- Language Server Protocol
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		config = function (_)
			require("IndY.plugin-configs.lsp-config")
		end
	},
	{ "ray-x/lsp_signature.nvim" },
	{ -- Autocompletion for LSP
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer word source
			"hrsh7th/cmp-path", -- Path source
			"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
			"rafamadriz/friendly-snippets", -- More Snippets
			{ -- Snippets engine
				"L3MON4D3/LuaSnip",
				config = function (_)
					require("IndY.plugin-configs.lua-snip")
				end
			},
		},
		config = function (_)
			require("IndY.plugin-configs.cmp")
		end
	},
	{ -- Syntax Highlighting and parsers
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		event = { "BufReadPre" },
		opts = require("IndY.plugin-configs.treesitter")
	},
	-- { -- Comment or Uncomment Lines
	-- 	"numToStr/Comment.nvim",
	-- 	dependencies = {
	-- 		{"JoosepAlviste/nvim-ts-context-commentstring", module = true}, -- Smarter Commenting
	-- 	},
	-- 	keys = {
	-- 		{ "gc"   , mode = {"n", "v"} },
	-- 		{ "gb"   , mode = {"n", "v"} },
	-- 		{ "<C-/>", mode = "i" }
	-- 	},
	-- 	opts = { ignore = "^$" }
	-- },
	{ -- Indent Guides
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = { indent = {char = "|", tab_char = "|"} }
	},
	{ -- Fuzzy Finder
		"ibhagwan/fzf-lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "FzfLua",
		opts = {
			'fzf-vim',
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		},
	},
	{
		"m4xshen/autoclose.nvim",
		event = { "InsertEnter" },
		opts = require("IndY.plugin-configs.autoclose"),
	},
	{ -- Colour Scheme
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function (_)
			require("kanagawa").setup({
				dimInactive = true,
				globalStatus = true,
				keywordStyle = { italic = false },
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					local theme = colors.theme
					return {
						Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },
						["@markup.link"] = { underline = true },
					}
				end,
			})
			vim.cmd [[colorscheme kanagawa]] -- Setting the Colourschme
		end
	},
	{ -- File manager
		"echasnovski/mini.files",
		lazy = false,
		opts = {},
	},
	{ -- Git
		"tpope/vim-fugitive",
		cmd = {"Git", "G"},
	},
	{ -- Deal with surroundings
		"echasnovski/mini.surround",
		event = { "BufReadPost", "BufNewFile" },
		config = function(_)
			require('mini.surround').setup {
				mappings = {
					add = "ys",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "gs",
					replace = "cs",
					update_n_lines = "",
				},
				search_method = "cover_or_next",
				highlight_duration = 2000,
			}
			-- Remap adding surrounding to Visual mode selection
			vim.keymap.del('x', 'ys')
			vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
			-- Make special mapping for "add surrounding for line"
			vim.keymap.set('n', 'yss', 'ys_', { remap = true })
		end,
	},
	{ -- Notes Taking
		"nvim-neorg/neorg",
		dependencies = "nvim-lua/plenary.nvim",
		build = ":Neorg sync-parsers",
		tag = "v7.0.0",
		-- ft = "norg",
		cmd = "Neorg",
		opts = require("IndY.plugin-configs.neorg"),
	},
	{ "nvim-tree/nvim-web-devicons" }, -- Icons
	{ -- Color picker and highlighter
		"uga-rosa/ccc.nvim",
		cmd = "CccHighlighterToggle",
		opts = {},
	},

	-- { -- Automatically makes pairs of (), [], etc.
	-- 	"altermo/ultimate-autopair.nvim",
	-- 	event = "InsertEnter",
	-- 	opts = { fastwarp = { enable = false, } },
	-- },
	-- { -- File Explorer
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = "nvim-tree/nvim-web-devicons", -- Various Icons
	-- 	cmd = {"NvimTreeToggle", "NvimTreeClose"},
	-- 	opts = require("IndY.plugin-configs.nvim-tree")
	-- },
	-- { -- A wrapper around the terminal functionality of neovim
	-- 	"akinsho/toggleterm.nvim",
	-- 	keys = [[<C-\>]],
	-- 	-- cmd = {":lua _Node_Toggle()", ":lua _Deno_Toggle()"},
	-- 	config = function (_)
	-- 		require("IndY.plugin-configs.toggleterm")
	-- 	end
	-- },
	-- { -- Git
	-- 	"lewis6991/gitsigns.nvim",
	-- 	dependencies = {"nvim-lua/plenary.nvim"},
	-- 	-- event = "BufEnter",
	-- 	-- Function to find the git root directory based on the current buffer's path
	-- 	cond = function()
	-- 	-- Use the current buffer's path as the starting point for the git search
	-- 		local current_file = vim.api.nvim_buf_get_name(0)
	-- 		local current_dir
	-- 		local cwd = vim.fn.getcwd()
	-- 		-- If the buffer is not associated with a file, return nil
	-- 		if current_file == "" then
	-- 			current_dir = cwd
	-- 		else
	-- 			-- Extract the directory from the current file's path
	-- 			current_dir = vim.fn.fnamemodify(current_file, ":h")
	-- 		end
	-- 		-- Find the Git root directory from the current file's path
	-- 		local _ = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	-- 		if vim.v.shell_error ~= 0 then
	-- 			return false -- Not git repo
	-- 		end
	-- 		return true
	-- 	end,
	-- 	opts = require("IndY.plugin-configs.gitsigns"),
	-- },
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	dependencies = {
	-- 		{"rcarriga/nvim-dap-ui"}
	-- 	},
	-- 	keys = "<Leader>d",
	-- 	config = function (_)
	-- 		require("IndY.plugin-configs.nvim-dap")
	-- 	end,
	-- },
	-- { -- Fuzzy Finder
	-- 	"nvim-telescope/telescope.nvim",
	-- 	dependencies = {"nvim-lua/plenary.nvim"},
	-- },
	-- { -- Shows the open buffers in a bufferline
	-- 	"akinsho/bufferline.nvim",
	-- 	dependencies = "nvim-tree/nvim-web-devicons", -- Various Icons
	-- 	event = "BufEnter",
	-- 	opts = require("IndY.plugin-configs.bufferline")
	-- },
	-- { -- For Web Development
	-- Choose b/w below for colors
	-- nvim-colortils/colortils.nvim
	-- brenoprata10/nvim-highlight-colors
	-- uga-rosa/ccc.nvim
	-- { -- API testing
	-- 	"NTBBloodbath/rest.nvim",
	-- 	ft = {"http"},
	-- 	opts = require("IndY.plugin-configs.rest")
	-- },
	-- { -- Emmet for vim bcoz the emmet lsp doesn"t have support for some things
	-- 	"mattn/emmet-vim",
	-- 	ft = {"html", "css", "javascript", "typescript", "vue", "javascriptreact", "typescriptreact"},
	-- 	config = fuction(_) [[require("IndY.plugin-configs.emmet")]] end
	-- },
	-- },
	-- {
	-- 	"marko-cerovac/material.nvim",
	-- 	config = function(_) "vim.g.material_style = "deep ocean"" end
	-- },
	-- {
	-- 	"ThePrimeagen/vim-be-good",
	-- 	cmd = "VimBeGood"
	-- },
}

require("lazy").setup({
	spec = plugins,
	ui = {
		border = "rounded"
	},
	defaults = {
		lazy = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
