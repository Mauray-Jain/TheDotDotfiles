	require("toggleterm").setup{
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 10
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		elseif term.direction == "float" then
			return 20
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = 'horizontal',
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
}

function _G.set_terminal_keymaps()
	local opts = {noremap = true}
	-- Terminal Mapping to exit --TERMINAL-- mode
	vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

local toggleTermGroup = vim.api.nvim_create_augroup("ToggleTermOpening", {clear = true})
vim.api.nvim_create_autocmd("TermOpen", {
	group = toggleTermGroup,
	pattern = "term://*",
	callback = function() set_terminal_keymaps() end
})

-- local Terminal = require("toggleterm.terminal").Terminal
-- local get = require('toggleterm.config').get
-- local size_func = get("size")
-- local direction = get("direction")
-- local size = size_func({direction = direction})

-- local node = Terminal:new({ cmd = "node", hidden = true })
-- local deno = Terminal:new({ cmd = "deno", hidden = true })

-- function _Node_Toggle()
-- 	node:toggle(size, direction)
-- end
-- function _Deno_Toggle()
-- 	deno:toggle(size, direction)
-- end
