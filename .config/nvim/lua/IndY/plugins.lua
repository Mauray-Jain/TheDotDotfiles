-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  vim.notify("Installing packer close and reopen Neovim...", vim.log.levels.INFO)
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup({
	function(use)
		use 'wbthomason/packer.nvim' -- Have packer manage itself
		use 'antoinemadec/FixCursorHold.nvim' -- This is rqd. till https://github.com/neovim/neovim/issues/12587 is open
		use { -- Various Icons
			'kyazdani42/nvim-web-devicons',
			config = [[require("IndY.plugin-configs.nvim-web-devicons")]]
		}
		use 'neovim/nvim-lspconfig' -- Language Server Protocol
		use { -- Autocompletion for LSP
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
				{ -- Helpful in completing vim.* while configuring or writing plugins
					'hrsh7th/cmp-nvim-lua',
					ft = {'lua'}
				},
			},
			config = [[require("IndY.plugin-configs.lsp.cmp")]]
		}
		use { -- Snippets engine
			'L3MON4D3/LuaSnip',
			requires = {
				'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
				{ -- More Snippets
					'rafamadriz/friendly-snippets',
					after = "LuaSnip"
				}
			},
			event = "InsertEnter",
			module = "luasnip",
			config = [[require("IndY.plugin-configs.lsp.luasnip")]]
		}
		use { -- Syntax Highlighting and parsers
			'nvim-treesitter/nvim-treesitter',
			requires = {
				{ -- Provides textobjects like af, if, ic, ac
					'nvim-treesitter/nvim-treesitter-textobjects',
					after = "nvim-treesitter"
				},
			},
			run = ':TSUpdate',
			event = "BufEnter",
			config = [[require("IndY.plugin-configs.treesitter")]]
		}
		use { -- Comment or Uncomment Lines
			'numToStr/Comment.nvim',
			requires = { -- Smarter Commenting
				{
					'JoosepAlviste/nvim-ts-context-commentstring',
					after = "nvim-treesitter",
				},
			},
			after = 'nvim-ts-context-commentstring',
			config = [[require("IndY.plugin-configs.comment")]]
		}
		use { -- Automatically makes pairs of (), [], etc.
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			after = "nvim-cmp",
			config = [[require("IndY.plugin-configs.nvim-autopairs")]]
		}
		use { -- Deal with surroundings
			'tpope/vim-surround',
			event = "BufEnter",
		}
		use { -- Git
			'lewis6991/gitsigns.nvim',
			requires = 'nvim-lua/plenary.nvim',
			event = "BufEnter",
			config = [[require("IndY.plugin-configs.gitsigns")]],
		}
		use { -- Indent Guides
			'lukas-reineke/indent-blankline.nvim',
			event = "BufEnter",
			config = [[require("IndY.plugin-configs.indent_blankline")]]
		}
		use { -- File Explorer
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons', -- Various Icons
			cmd = {"NvimTreeToggle", "NvimTreeClose"},
			config = [[require("IndY.plugin-configs.nvim-tree")]]
		}
		-- use { -- Fuzzy Finder
		-- 	'nvim-telescope/telescope.nvim',
		-- 	requires = 'nvim-lua/plenary.nvim',
		-- }
		use { -- Fuzzy Finder 2
			'ibhagwan/fzf-lua',
			requires = 'kyazdani42/nvim-web-devicons',
			cmd = "FzfLua",
			module = "fzf-lua",
			config = [[require("IndY.plugin-configs.fzf-lua")]]
		}
		use { -- Shows the open buffers in a bufferline
			'akinsho/bufferline.nvim',
			requires = 'kyazdani42/nvim-web-devicons', -- Various Icons
			event = "BufEnter",
			config = [[require("IndY.plugin-configs.bufferline")]]
		}
		use { -- A wrapper around the terminal functionality of neovim
			'akinsho/toggleterm.nvim',
			keys = [[<C-\>]],
			cmd = {"lua _Node_Toggle()", "lua _Deno_Toggle()"},
			config = [[require("IndY.plugin-configs.toggleterm")]]
		}
		-- use { -- For Web Development
			-- { -- Displaying colours
			-- 	'RRethy/vim-hexokinase',
			-- 	run = "make hexokinase",
			-- 	cmd = {"HexokinaseTurnOn", "HexokinaseToggle"},
			-- 	config = [[require("IndY.plugin-configs.vim-hexokinase")]]
			-- },
			-- { -- API testing
			-- 	'NTBBloodbath/rest.nvim',
			-- 	ft = {"http"},
			-- 	config = [[require("IndY.plugin-configs.rest")]]
			-- },
			-- { -- Something like live-server
			-- 	'turbio/bracey.vim',
			-- 	run = "npm install --prefix server",
			-- 	cmd = "Bracey",
			-- 	config = [[require("IndY.plugin-configs.bracey")]]
			-- },
			-- { -- Emmet for vim bcoz the emmet lsp doesn't have support for some things
			-- 	'mattn/emmet-vim',
			-- 	ft = {"html", "css", "javascript", "typescript", "vue", "javascriptreact", "typescriptreact"},
			-- 	config = [[require("IndY.plugin-configs.emmet")]]
			-- },
		-- }
		use { -- Colour Scheme
			'rebelot/kanagawa.nvim',
			config = [[require("IndY.plugin-configs.kanagawa")]]
		}
		use { -- Notes Taking
			'nvim-neorg/neorg',
			requires = 'nvim-lua/plenary.nvim',
			ft = "norg",
			after = 'nvim-treesitter',
			config = [[require("IndY.plugin-configs.neorg")]]
		}
		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,

	config = {
		-- Have packer use a popup window
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
}})
