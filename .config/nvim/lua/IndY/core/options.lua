-- Some general settings, see :h[elp] options
vim.o.termguicolors = true
vim.o.breakindent = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = "a"

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false
vim.o.smartindent = true

vim.o.swapfile = false
vim.o.backup = false

vim.o.splitbelow = true
vim.o.splitright = true
vim.wo.signcolumn = "yes"
vim.o.scrolloff = 8
vim.o.laststatus = 3

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.completeopt = "menuone,preview"
vim.o.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
vim.g.markdown_fenced_languages = { -- For deno lsp server
	"ts=typescript"
}
vim.g.skip_ts_context_commentstring_module = true
vim.g.python3_host_prog = "/usr/sbin/python"
-- vim.g.python_recommended_style = 0

-- NetRW settings
-- Turn off netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
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
