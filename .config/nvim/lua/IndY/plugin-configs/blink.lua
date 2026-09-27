return {
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		menu = {
			border = 'single',
			draw = {
				components = {
					source_name = {
						width = { fill = true },
						text = function(ctx)
							return '[' .. ctx.source_name .. ']'
						end,
						highlight = 'Normal',
					},
				},
				gap = 2,
				columns = { { "label" }, { "kind_icon", gap = 1, "kind" }, { "source_name" } },
			},
			winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
		},
		documentation = {
			auto_show = true,
			treesitter_highlighting = true,
			auto_show_delay_ms = 0,
			window = { border = 'rounded', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder', },
		},
	},
	keymap = {
		['<Tab>'] = false,
		['<S-Tab>'] = false,
		['<Up>'] = false,
		['<Down>'] = false,
		-- ['<C-k>'] = { 'snippet_forward', 'fallback' },
		-- ['<C-j>'] = { 'snippet_backward', 'fallback' },
		['<C-k>'] = false,
		['<C-j>'] = false,
	},
	appearance = {
		kind_icons = {
			Text = '󰉿',
			Method = '󰊕',
			Function = '󰊕',
			Constructor = '󰒓',

			Field = '󰜢',
			Variable = '󰆦',
			Property = '󰖷',

			Class = '󰌗',
			Interface = '󱡠',
			Struct = '',
			Module = '󰅩',

			Unit = '󰪚',
			Value = '󰦨',
			Enum = '󰦨',
			EnumMember = '󰦨',

			Keyword = '󰌆',
			Constant = '󰏿',

			Snippet = '󰘍',
			Color = '󰏘',
			File = '󰈔',
			Reference = '󰬲',
			Folder = '󰉋',
			Event = '󱐋',
			Operator = '󰆕',
			TypeParameter = '󰬛',
		},
	},
}
