-- Setup
return {
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
