-- Some general settings, see :h[elp] options
vim.o.termguicolors = true
vim.o.breakindent = true
vim.wo.number = true -- Pretty obvious
vim.wo.relativenumber = true -- Obvious again
vim.o.mouse = "a" -- Make the screen clickable
vim.o.tabstop = 2 -- Tab appears as 2 characters wide
vim.o.shiftwidth = 2 -- Tab appears as 2 characters wide
vim.o.expandtab = false -- Tab >>> Spaces
vim.o.smartindent = true -- Self explanatory
vim.o.writebackup = true -- Make a backup file
vim.o.backup = false -- After making backup file delete it after writing successfully
vim.o.splitbelow = true -- Split Below
vim.o.splitright = true -- Split Right
vim.wo.signcolumn = "yes" -- Sign column is important
vim.o.scrolloff = 8 -- Keep atleast 8 lines above and below the cursor
vim.o.laststatus = 3 -- Keep a single statusline for all windows
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.completeopt = "menuone,preview"
vim.o.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
vim.g.markdown_fenced_languages = { -- For deno lsp server
	"ts=typescript"
}
vim.g.python3_host_prog = "/usr/sbin/python"
vim.g.skip_ts_context_commentstring_module = true
-- vim.g.python_recommended_style = 0 -- Change recommended style to my style
