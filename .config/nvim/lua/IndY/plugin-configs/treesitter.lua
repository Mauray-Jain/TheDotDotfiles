-- TreeSitter Setup
-- https://github.com/BirdeeHub/birdeevim/blob/3ccb6c592bcdd55b9cb648d6affd8cd2f372b215/lua/birdee/plugins/nestsitter.lua#L10-L49

local function try_attach(buf, lang)
	if not vim.treesitter.language.add(lang) then
		return false
	end
	vim.treesitter.start(buf, lang)
	vim.b.did_indent = 1
	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	return true
end

local installable = require("nvim-treesitter").get_available()

vim.api.nvim_create_autocmd('FileType', {
	callback = function(ev)
		local buf, ft = ev.buf, ev.match
		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end
		if not try_attach(ev.buf, ev.match) then
			if vim.tbl_contains(installable, lang) then
				require("nvim-treesitter").install(lang):await(function()
					try_attach(buf, lang)
				end)
			end
		end
	end,
})
