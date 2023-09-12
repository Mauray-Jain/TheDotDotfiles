-- Keybindings
-- Navigate through buffers [<Leader>b - buffers]
vim.keymap.set("n", "<Leader>bn", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<Leader>bp", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Leader>bc", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<Leader>bx", "<Cmd>NvimTreeClose<CR><Cmd>bwipeout<CR>")
-- Move the current buffer backwards or forwards in the bufferline
vim.keymap.set("n", "<Leader>bbn", "<Cmd>BufferLineMoveNext<CR>")
vim.keymap.set("n", "<Leader>bbp", "<Cmd>BufferLineMovePrev<CR>")
-- Sort buffers by directory, language, or a custom criteria
-- vim.keymap.set("n", "<Leader>be", "<Cmd>BufferLineSortByExtension<CR>")
-- vim.keymap.set("n", "<Leader>bd", "<Cmd>BufferLineSortByDirectory<CR>")
-- vim.keymap.set("n", "<Leader>bbc", function ()
-- 	require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)
-- end)

-- Setup
require("bufferline").setup{
	options = {
		mode = "buffers",
		-- groups = {
		-- 	options = {
		-- 		toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
		-- 	},
		-- 	items = {
		-- 		{
		-- 			name = "Nvim Config",
		-- 		}
		-- 	}
		-- },
		numbers = function (opts)
			return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
		end,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function (count, level, _, context)
			if context.buffer:current() then
				return ''
			end
			local icon = level:match("error") and " " or " "
			return " " .. icon ..count
		end,
		buffer_close_icon = "",
    -- buffer_close_icon = '',
    modified_icon = "●",
    close_icon = "",
		offsets = {
			{ -- Rename bufferline over NvimTree
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "center"
			},
		},
	}
}
