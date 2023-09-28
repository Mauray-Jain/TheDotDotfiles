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

local plugins = {
	{ -- Various Icons
		'nvim-tree/nvim-web-devicons',
		opts = require("IndY.plugin-configs.nvim-web-devicons")
	},
	'neovim/nvim-lspconfig', -- Language Server Protocol
	{ -- Autocompletion for LSP
		'hrsh7th/nvim-cmp',
		dependencies = {
			{'hrsh7th/cmp-nvim-lsp'}, -- LSP source for nvim-cmp
			{ -- Helpful in completing vim.* while configuring or writing plugins
				'hrsh7th/cmp-nvim-lua',
				ft = {'lua'}
			},
		},
		event = "InsertEnter",
		config = function (_)
			require("IndY.plugin-configs.lsp.cmp")
		end
	},
	{ -- Snippets engine
		'L3MON4D3/LuaSnip',
		dependencies = {
			{'saadparwaiz1/cmp_luasnip'}, -- Snippets source for nvim-cmp
			{ -- More Snippets
				'rafamadriz/friendly-snippets',
				event = "InsertEnter"
			}
		},
		event = "InsertEnter",
		config = function (_)
			require("IndY.plugin-configs.lsp.luasnip")
		end
	},
	{ -- Syntax Highlighting and parsers
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			{'nvim-treesitter/nvim-treesitter-textobjects'}, -- Provides textobjects like af, if, ic, ac
		},
		build = ':TSUpdate',
		main = 'nvim-treesitter.configs',
		event = "BufEnter",
		opts = require("IndY.plugin-configs.treesitter")
	},
	{ -- Comment or Uncomment Lines
		'numToStr/Comment.nvim',
		dependencies = {
			{'JoosepAlviste/nvim-ts-context-commentstring', module = true}, -- Smarter Commenting
		},
		event = 'BufEnter',
		opts = require("IndY.plugin-configs.comment")
	},
	{ -- Automatically makes pairs of (), [], etc.
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = require("IndY.plugin-configs.nvim-autopairs")
	},
	{ -- Deal with surroundings
		'tpope/vim-surround',
		event = "BufEnter",
	},
	{ -- Git
		'lewis6991/gitsigns.nvim',
		dependencies = {'nvim-lua/plenary.nvim'},
		event = "BufEnter",
		opts = require("IndY.plugin-configs.gitsigns"),
	},
	{ -- Indent Guides
		'lukas-reineke/indent-blankline.nvim',
		event = "BufEnter",
		main = "ibl",
		opts = require("IndY.plugin-configs.indent_blankline")
	},
	{ -- File Explorer
		'nvim-tree/nvim-tree.lua',
		dependencies = 'nvim-tree/nvim-web-devicons', -- Various Icons
		cmd = {"NvimTreeToggle", "NvimTreeClose"},
		opts = require("IndY.plugin-configs.nvim-tree")
	},
	-- { -- Fuzzy Finder
	-- 	'nvim-telescope/telescope.nvim',
	-- 	dependencies = {'nvim-lua/plenary.nvim'},
	-- },
	{ -- Fuzzy Finder 2
		'ibhagwan/fzf-lua',
		dependencies = 'nvim-tree/nvim-web-devicons',
		cmd = "FzfLua",
		opts = require("IndY.plugin-configs.fzflua")
	},
	{ -- Shows the open buffers in a bufferline
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons', -- Various Icons
		event = "BufEnter",
		opts = require("IndY.plugin-configs.bufferline")
	},
	{ -- A wrapper around the terminal functionality of neovim
		'akinsho/toggleterm.nvim',
		keys = [[<C-\>]],
		-- cmd = {":lua _Node_Toggle()", ":lua _Deno_Toggle()"},
		config = function (_)
			require("IndY.plugin-configs.toggleterm")
		end
	},
	-- { -- For Web Development
	-- Choose b/w below for colors
	-- nvim-colortils/colortils.nvim
	-- brenoprata10/nvim-highlight-colors
	-- uga-rosa/ccc.nvim

	-- { -- API testing
	-- 	'NTBBloodbath/rest.nvim',
	-- 	ft = {"http"},
	-- 	opts = require("IndY.plugin-configs.rest")
	-- },
	-- { -- Emmet for vim bcoz the emmet lsp doesn't have support for some things
	-- 	'mattn/emmet-vim',
	-- 	ft = {"html", "css", "javascript", "typescript", "vue", "javascriptreact", "typescriptreact"},
	-- 	config = fuction(_) [[require("IndY.plugin-configs.emmet")]] end
	-- },
	-- },
	{ -- Colour Scheme
		'rebelot/kanagawa.nvim',
		lazy = false,
		priority = 1000,
		config = function (_)
			require("IndY.plugin-configs.kanagawa")
		end
	},
	--[[ {
	'marko-cerovac/material.nvim',
	config = function(_) "vim.g.material_style = 'deep ocean'" end
	}, ]]
	-- { -- Notes Taking
	-- 	'nvim-neorg/neorg',
	-- 	dependencies = 'nvim-lua/plenary.nvim',
	-- 	build = ":Neorg sync-parsers",
	-- 	-- ft = "norg",
	-- 	opts = require("IndY.plugin-configs.neorg")
	-- },
	{
		'ThePrimeagen/vim-be-good',
		cmd = 'VimBeGood'
	},
}

local opts = {
	ui = {
		border = "rounded"
	}
}

require("lazy").setup(plugins, opts)
