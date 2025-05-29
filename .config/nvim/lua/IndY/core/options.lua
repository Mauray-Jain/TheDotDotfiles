-- Some general settings, see :h[elp] options

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

local providers = { "perl", "node", "ruby", "python", "python3" }
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.opt.shell = "/bin/zsh -f"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.foldlevelstart = 1

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "auto:2"
vim.opt.scrolloff = 8
vim.opt.laststatus = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.conceallevel = 2

vim.opt.completeopt = {"menu", "menuone", "preview", "noselect"}
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

vim.opt.formatoptions = vim.opt.formatoptions
	- "a"
	+ "t"
	+ "c"
	+ "q"
	+ "/"
	+ "r"
	+ "n"
	+ "j"
	- "2"

vim.opt.fillchars = {
	eob = " ",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	fold = " ",
	diff = "─",
	msgsep = "‾",
	foldsep = "│",
	foldopen = "▾",
	foldclose = "▸",
}

vim.g.markdown_fenced_languages = { -- For deno lsp server
	"ts=typescript"
}
vim.g.skip_ts_context_commentstring_module = true
vim.g.c_syntax_for_h = true -- Set C syntax for '.h' header files (default is C++)
vim.g.user_emmet_leader_key='<C-e>'

-- NetRW settings
-- vim.g.netrw_winsize = 35
-- vim.g.netrw_banner = 0
-- vim.g.netrw_keepdir = 0
-- vim.g.netrw_sort_sequence = [[[\/]$,*]] -- Show directories first (sorting)
-- vim.g.netrw_sizestyle = "H"
-- vim.g.netrw_liststyle = 3 -- 3 : tree style listing

-- -- Patterns for hiding files, e.g. node_modules
-- -- NOTE: this works by reading '.gitignore' file
-- vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()

-- vim.g.netrw_hide = 1 -- show not-hidden files
-- vim.g.netrw_preview = 1 -- Preview files in a vertical split window
-- vim.g.netrw_browse_split = 4 -- open previous window)
-- vim.cmd("hi! link netrwMarkFile Search")

-- -- Setup file operations commands
-- if package.config:sub(1, 1) == "/" then
-- 	vim.g.netrw_localcopydircmd = "cp -r"
-- 	vim.g.netrw_localmkdir = "mkdir -p"
-- 	vim.g.netrw_localrmdir = "rm -r"
-- end
