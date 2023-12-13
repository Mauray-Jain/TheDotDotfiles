-- Install lazy if not already present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Spec
local plugins = {
	"neovim/nvim-lspconfig", -- Language Server Protocol
	{ -- Autocompletion for LSP
		"hrsh7th/nvim-cmp",
		dependencies = {
			{"hrsh7th/cmp-nvim-lsp", lazy = true}, -- LSP source for nvim-cmp
		},
		event = "InsertEnter",
		config = function (_)
			require("IndY.plugin-configs.lsp.cmp")
		end
	},
	{ -- Snippets engine
		"L3MON4D3/LuaSnip",
		dependencies = {
			{"saadparwaiz1/cmp_luasnip", lazy = true}, -- Snippets source for nvim-cmp
			{ -- More Snippets
				"rafamadriz/friendly-snippets",
				lazy = true
			}
		},
		lazy = true,
		config = function (_)
			require("IndY.plugin-configs.lsp.luasnip")
		end
	},
	{ -- Syntax Highlighting and parsers
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{"nvim-treesitter/nvim-treesitter-textobjects", lazy = true}, -- Provides textobjects like af, if, ic, ac
		},
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		event = "UIEnter",
		config = function (_)
			require("IndY.plugin-configs.treesitter")
		end
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{"rcarriga/nvim-dap-ui"}
		},
		keys = "<Leader>d",
		config = function (_)
			require("IndY.plugin-configs.nvim-dap")
		end,
	},
	{ -- Comment or Uncomment Lines
		"numToStr/Comment.nvim",
		dependencies = {
			{"JoosepAlviste/nvim-ts-context-commentstring", module = true}, -- Smarter Commenting
		},
		keys = {{"gc", mode = {"n", "v"}}, {"gb", mode = {"n", "v"}}, {"<C-/>", mode = "i"}},
		opts = {ignore = "^$",}
	},
	{ -- Automatically makes pairs of (), [], etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		keys = "<A-e>",
		opts = require("IndY.plugin-configs.nvim-autopairs")
	},
	{ -- Deal with surroundings
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{ -- Git
		"lewis6991/gitsigns.nvim",
		dependencies = {"nvim-lua/plenary.nvim"},
		-- event = "BufEnter",
		-- Function to find the git root directory based on the current buffer's path
		cond = function()
		-- Use the current buffer's path as the starting point for the git search
			local current_file = vim.api.nvim_buf_get_name(0)
			local current_dir
			local cwd = vim.fn.getcwd()
			-- If the buffer is not associated with a file, return nil
			if current_file == "" then
				current_dir = cwd
			else
				-- Extract the directory from the current file's path
				current_dir = vim.fn.fnamemodify(current_file, ":h")
			end

			-- Find the Git root directory from the current file's path
			local _ = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
			if vim.v.shell_error ~= 0 then
				return false -- Not git repo
			end
			return true
		end,
		opts = require("IndY.plugin-configs.gitsigns"),
	},
	{ -- Indent Guides
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = require("IndY.plugin-configs.indent-blankline")
	},
	-- { -- Fuzzy Finder
	-- 	"nvim-telescope/telescope.nvim",
	-- 	dependencies = {"nvim-lua/plenary.nvim"},
	-- },
	{ -- Fuzzy Finder 2
		"ibhagwan/fzf-lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "FzfLua",
		config = function(_)
			require("IndY.plugin-configs.fzflua")
		end
	},
	{ -- File Explorer
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons", -- Various Icons
		cmd = {"NvimTreeToggle", "NvimTreeClose"},
		opts = require("IndY.plugin-configs.nvim-tree")
	},
	{ -- Various Icons
		"nvim-tree/nvim-web-devicons",
		opts = require("IndY.plugin-configs.nvim-web-devicons")
	},
	-- { -- Shows the open buffers in a bufferline
	-- 	"akinsho/bufferline.nvim",
	-- 	dependencies = "nvim-tree/nvim-web-devicons", -- Various Icons
	-- 	event = "BufEnter",
	-- 	opts = require("IndY.plugin-configs.bufferline")
	-- },
	{ -- A wrapper around the terminal functionality of neovim
		"akinsho/toggleterm.nvim",
		keys = [[<C-\>]],
		-- cmd = {":lua _Node_Toggle()", ":lua _Deno_Toggle()"},
		config = function (_)
			require("IndY.plugin-configs.toggleterm")
		end
	},
	{
		"uga-rosa/ccc.nvim",
		cmd = "CccHighlighterToggle",
		config = function (_) require("ccc").setup() end,
	},
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
	{ -- Colour Scheme
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function (_)
			require("IndY.plugin-configs.kanagawa")
		end
	},
	--[[ {
	"marko-cerovac/material.nvim",
	config = function(_) "vim.g.material_style = "deep ocean"" end
	}, ]]
	-- { -- Notes Taking
	-- 	"nvim-neorg/neorg",
	-- 	dependencies = "nvim-lua/plenary.nvim",
	-- 	build = ":Neorg sync-parsers",
	-- 	-- ft = "norg",
	-- 	opts = require("IndY.plugin-configs.neorg")
	-- },
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood"
	},
}

-- Opts for lazy
local opts = {
	ui = {
		border = "rounded"
	}
}

require("lazy").setup(plugins, opts)
