-- Reference:
-- https://github.com/echasnovski/mini.statusline/blob/main/lua/mini/statusline.lua
--  mode | git_branch %= file %= lsp | tux encoding | line:column %age

local ok, devicons = pcall(require, "nvim-web-devicons")

-- {{{Mode component

-- https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#crash-course-the-vimode

local mode_names = {-- {{{
	n = "N",
	no = "N?",
	nov = "N?",
	noV = "N?",
	["no\22"] = "N?",
	niI = "Ni",
	niR = "Nr",
	niV = "Nv",
	nt = "Nt",
	ntT = "Nt",
	v = "V",
	vs = "Vs",
	V = "V_",
	Vs = "Vs",
	["\22"] = "^V",
	["\22s"] = "^V",
	s = "S",
	S = "S_",
	["\19"] = "^S",
	i = "I",
	ic = "Ic",
	ix = "Ix",
	R = "R",
	Rc = "Rc",
	Rx = "Rx",
	Rv = "Rv",
	Rvc = "Rv",
	Rvx = "Rv",
	c = "C",
	cv = "Ex",
	r = "...",
	rm = "mode",
	["r?"] = "?",
	["!"] = "!",
	t = "T",
}-- }}}

local mode_colors = {-- {{{
	n = "Stl_mode_red",
	i = "Stl_mode_green",
	v = "Stl_mode_cyan",
	V = "Stl_mode_cyan",
	["\22"] = "Stl_mode_cyan",
	c = "Stl_mode_orange",
	s = "Stl_mode_purple",
	S = "Stl_mode_purple",
	["\19"] = "Stl_mode_purple",
	R = "Stl_mode_orange",
	r = "Stl_mode_orange",
	["!"] = "Stl_mode_red",
	t = "Stl_mode_red",
}-- }}}

-- Main content
local function mode_content()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_letter = string.sub(current_mode, 1, 1)
	return string.format("%%#%s# %2.2s %%*", mode_colors[mode_letter], mode_names[current_mode])
end
--}}}

--{{{Git component

local function is_git_repo()
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = vim.fn.getcwd()
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end
	-- Find the Git root directory from the current file's path
	local _ = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		return false -- Not git repo
	end
	return true
end

local function git_content()
	if not is_git_repo() then
		return ""
	end
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
	if vim.v.shell_error ~= 0 then
		return ""
	end
	return string.format("|%%#Stl_mode_orange#  %s%%*", branch)
end

--}}}

--{{{LSP status

local function diagnostic_get(severity)
	return vim.tbl_count(vim.diagnostic.get(0, {
		severity = vim.diagnostic.severity[severity],
	}))
end

local function lsp_diagnostics()
	if vim.diagnostic.is_disabled(0) then
		return ""
	end
	local errors = diagnostic_get("ERROR")
	local warning = diagnostic_get("WARN")
	local hint = diagnostic_get("HINT")
	local str = "%%#DiagnosticError#%d %%#DiagnosticWarn#%d %%#DiagnosticInfo#%d %%*| "
	return string.format(str, errors, warning, hint)
end

--}}}

--{{{File component

local function file_icon()
	if not ok then
		return "%#DevIconDefault# " -- This is ok as even if hl grp doesn't exist it gives default hl
	end
	local filename = vim.fn.expand("%:t")
	local extension = vim.fn.expand("%:e")
	local icon, icon_hl = devicons.get_icon(filename, extension, { default = true })
	return string.format("%%#%s#%s %%*", icon_hl, icon)
end

local function file_content()
	if vim.bo.buftype == "terminal" then
		return "term:%t"
	end
	return "%f%m%r"
end

local os_icons = {
	["mac"]  = "",
	["dos"]  = "",
	["unix"] = "",
}

local function file_info()
	local encoding = vim.bo.fileencoding
	if encoding == "" then encoding = vim.o.encoding end
	encoding = string.upper(encoding)
	local formaticon = os_icons[vim.bo.fileformat]
	return string.format("%s %s", formaticon, encoding)
end

--}}}

-- Make highlight grps
local colors = { "red", "green", "cyan", "orange", "purple" }
for _, value in ipairs(colors) do
	local name = string.format("Stl_mode_%s", value)
	local val = { fg = value, bold = true }
	vim.api.nvim_set_hl(0, name, val)
end

function _G.Statusline()
	return table.concat({
		mode_content(),
		git_content(),
		"%=",
		file_icon(),
		file_content(),
		"%=",
		lsp_diagnostics(),
		file_info(),
		" | ",
		"%03l,%-2c %3p%%",
	})
end

-- vim:fdm=marker
