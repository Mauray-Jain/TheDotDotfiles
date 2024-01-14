local M = {}

M.modes = setmetatable({
	['n'] = {"Normal", "Nor"}, -- Normal
	['no'] = {"N·OpPd", "N·P"}, -- Operator-pending (forced blockwise |o_CTRL-V|)
	-- ['nov'] = {}, -- Operator-pending (forced charwise |o_v|)
	-- ['noV'] = {}, -- Operator-pending (forced linewise |o_V|)
	['niI'] = {"I·Norm", "I·N"}, -- Normal using |i_CTRL-O| in |Insert-mode|
	['niR'] = {"I·Repc", "I·R"}, -- Normal using |i_CTRL-O| in |Replace-mode|
	-- ['niV'] = {}, -- Normal using |i_CTRL-O| in |Virtual-Replace-mode|
	['nt'] = {"T·Norm", "T·N"}, -- Normal in |terminal-emulator| (insert goes to Terminal mode)
	['v'] = {"Visual", "Vis"}, -- Visual by character
	-- ['vs'] = {}, -- Visual by character using |v_CTRL-O| in Select mode
	['V'] = {"V·Line", "V·L"}, -- Visual by line
	-- ['Vs'] = {}, -- Visual by line using |v_CTRL-O| in Select mode
	[''] = {"V·Blok", "V·B"}, -- Visual blockwise
	-- ['v'] = {}, -- Visual blockwise using |v_CTRL-O| in Select mode
	['s'] = {"Select", "Sel"}, -- Select by character
	['S'] = {"S·Line", "S·L"}, -- Select by line
	-- [''] = {}, -- Select blockwise
	['i'] = {"Insert", "Ins"}, -- Insert
	['ic'] = {"I·Comp", "I·C"}, -- Insert mode completion |compl-generic|
	['ix'] = {"I·CtrX", "I·X"}, -- Insert mode |i_CTRL-X| completion
	['R'] = {"Rplace", "Rpl"}, -- Replace |R|
	['Rc'] = {"R·Comp", "R·C"}, -- Replace mode completion |compl-generic|
	['Rx'] = {"R·CtrX", "R·X"}, -- Replace mode |i_CTRL-X| completion
	['Rv'] = {"V·Repl", "V·R"}, -- Virtual Replace |gR|
	['Rvc'] = {"V·Comp", "V·C"}, -- Virtual Replace mode completion |compl-generic|
	['Rvx'] = {"VR·C-X", "V·X"}, -- Virtual Replace mode |i_CTRL-X| completion
	['c'] = {"Cmmand", "Cmd"}, -- Command-line editing
	['cv'] = {"ExMode", "ExM"}, -- Vim Ex mode |gQ|
	['r'] = {"Prompt", "Pmt"}, -- Hit-enter prompt
	['rm'] = {".More.", "Mor"}, -- The -- more -- prompt
	['r?'] = {"Cnfirm", "Cnf"}, -- A |:confirm| query of some sort
	['!'] = {"!Shell", "Shl"}, -- Shell or external command is executing
	['t'] = {"Trmnal", "Trm"}, -- Terminal mode: keys go to the job
}, {
	__index = function ()
		return {"Unknow", "Unk"}
	end
})

M.get_mode = function (self, truncated)
	local mode = vim.api.nvim_get_mode()
	local index = 1
	if truncated then
		index = 2
	end
	return string.format(" %s ", self.modes[mode][index])
end

return M
