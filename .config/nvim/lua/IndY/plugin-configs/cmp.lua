-- nvim-cmp setup
-- Call cmp under a protected call to avoid warnings at cmp.setup
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local icons = {
	Class = "󰌗 ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = "了 ",
	EnumMember = " ",
	Field = "󰄶 ",
	File = " ",
	Folder = " ",
	Function = " ",
	Interface = "󰜰 ",
	Keyword = "󰌆 ",
	Method = "ƒ ",
	Module = "󰏗 ",
	Property = " ",
	Snippet = "󰘍 ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = "󰎠 ",
	Variable = " ",
	Operator = "󰆕 ",
	Event = " ",
	Reference = " ",
}

cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm {
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		-- ['<Tab>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	-- elseif luasnip.expand_or_locally_jumpable() then
		-- 	-- 	luasnip.expand_or_jump()
		-- 		-- elseif luasnip.expandable() then
		-- 		-- 	luasnip.expand()
		-- 		-- elseif luasnip.jumpable(1) then
		-- 		-- 	luasnip.jump(1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {"i", "s"}),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 		-- elseif luasnip.jumpable(-1) then
		-- 		-- 	luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {"i", "s"}),
	},
	sources = cmp.config.sources({
		-- { name = 'nvim_lua' },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" }
	}),
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				-- buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				-- nvim_lua = "[Lua]",
				-- latex_symbols = "[LaTeX]",
				neorg = "[Neorg]",
			})[entry.source.name]
			return vim_item
		end
  },
	confirm_opts = {
		-- behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	view = {
		entries = {name = 'custom', selection_order = 'near_cursor' },
	},
	experimental = {
		ghost_text = false,
	},
}

-- cmp.setup.filetype('norg', {
-- 	sources = {
-- 		{ name = 'neorg' },
--     { name = 'luasnip' },
-- 	},
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" }
	}
})
