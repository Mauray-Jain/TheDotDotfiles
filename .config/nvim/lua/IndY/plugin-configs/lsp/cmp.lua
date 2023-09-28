-- nvim-cmp setup
local luasnip = require "luasnip"
-- Call cmp under a protected call to avoid warnings at cmp.setup
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
-- Automatically wrap functions in lisp
-- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "fennel"

local icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = "了 ",
	EnumMember = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = " ",
	Interface = "ﰮ ",
	Keyword = " ",
	Method = "ƒ ",
	Module = " ",
	Property = " ",
	Snippet = "﬌ ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
	Operator = " ",
	Event = " ",
	Reference = " ",
}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		-- These conflict with my mappings for LuaSnip
		-- ['<C-k>'] = cmp.mapping.select_prev_item(),
		-- ['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm {
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_locally_jumpable() then
			-- 	luasnip.expand_or_jump()
				-- elseif luasnip.expandable() then
				-- 	luasnip.expand()
				-- elseif luasnip.jumpable(1) then
				-- 	luasnip.jump(1)
			else
				fallback()
			end
		end, {"i", "s"}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				-- elseif luasnip.jumpable(-1) then
				-- 	luasnip.jump(-1)
			else
				fallback()
			end
		end, {"i", "s"}),
	},
	sources = {
		-- Following properties can also be specified here:
		-- keyword_length: To enable completion for a source only when you cross a specified number of keywords
		-- priority: To give priority on the basis of numbers
		-- max_item_count: To limit the number of items coming from a source
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				-- buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
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

cmp.setup.filetype('norg', {
	sources = {
		{ name = 'neorg' },
    { name = 'luasnip' },
	},
})
