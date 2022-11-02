local M = {}

M.modes = setmetatable({
	['n'] = {"Normal", "N"}, -- Normal
	['no'] = {"N·OpPd", "N·P"}, -- Operator-pending
	['nov'] = {}, -- Operator-pending (forced charwise |o_v|)
	['noV'] = {}, -- Operator-pending (forced linewise |o_V|)
	['no'] = {}, -- Operator-pending (forced blockwise |o_CTRL-V|)
	['niI'] = {}, -- Normal using |i_CTRL-O| in |Insert-mode|
	['niR'] = {}, -- Normal using |i_CTRL-O| in |Replace-mode|
	['niV'] = {}, -- Normal using |i_CTRL-O| in |Virtual-Replace-mode|
	['nt'] = {}, -- Normal in |terminal-emulator| (insert goes to Terminal mode)
	['v'] = {}, -- Visual by character
	['vs'] = {}, -- Visual by character using |v_CTRL-O| in Select mode
	['V'] = {}, -- Visual by line
	['Vs'] = {}, -- Visual by line using |v_CTRL-O| in Select mode
	[''] = {}, -- Visual blockwise
	['s'] = {}, -- Visual blockwise using |v_CTRL-O| in Select mode
	['s'] = {}, -- Select by character
	['S'] = {}, -- Select by line
	[''] = {}, -- Select blockwise
	['i'] = {"Insert", "I"}, -- Insert
	['ic'] = {}, -- Insert mode completion |compl-generic|
	['ix'] = {}, -- Insert mode |i_CTRL-X| completion
	['R'] = {"Rplace", "R"}, -- Replace |R|
	['Rc'] = {}, -- Replace mode completion |compl-generic|
	['Rx'] = {}, -- Replace mode |i_CTRL-X| completion
	['Rv'] = {}, -- Virtual Replace |gR|
	['Rvc'] = {}, -- Virtual Replace mode completion |compl-generic|
	['Rvx'] = {}, -- Virtual Replace mode |i_CTRL-X| completion
	['c'] = {"Cmmand", "C"}, -- Command-line editing
	['cv'] = {}, -- Vim Ex mode |gQ|
	['r'] = {}, -- Hit-enter prompt
	['rm'] = {}, -- The -- more -- prompt
	['r?'] = {}, -- A |:confirm| query of some sort
	['!'] = {}, -- Shell or external command is executing
	['t'] = {}, -- Terminal mode: keys go to the job
}, {
	__index = function ()
		return {"Unknown", "U"}
	end
})

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
