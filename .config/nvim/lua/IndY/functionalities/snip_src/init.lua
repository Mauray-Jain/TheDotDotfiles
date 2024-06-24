local M = {}
local source = {}

function source:complete(params, callback)
	callback({
		{ label = 'January' },
		{ label = 'February' },
		{ label = 'March' },
		{ label = 'April' },
		{ label = 'May' },
		{ label = 'June' },
		{ label = 'July' },
		{ label = 'August' },
		{ label = 'September' },
		{ label = 'October' },
		{ label = 'November' },
		{ label = 'December' },
	})
end

---Resolve completion item (optional). This is called right before the completion is about to be displayed.
---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
function source:resolve(completion_item, callback)
	callback(completion_item)
end

---Executed after the item was selected.
function source:execute(completion_item, callback)
	callback(completion_item)
end

function M.setup()
	require('cmp').register_source('month', source)
end


return M
