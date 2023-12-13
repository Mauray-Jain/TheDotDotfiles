local M = {}

M.truncating_width = setmetatable({ -- Set the width to truncate a component
	mode = 80,
	git_status = 90,
	filename = 140,
	line_col = 60,
	filetype = 60,
}, {
	__index = function () -- This is for some edge cases which is not in the main table
		return 80
	end
})

M.hl_groups = {
	mode = "%#StatusLineMode#",
}

return M
