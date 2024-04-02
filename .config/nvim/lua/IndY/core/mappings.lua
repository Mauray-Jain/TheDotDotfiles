-- My key bindings
-- Remove Spacebar mapping so that I can make it the leader key
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Editing Config file anytime needed
vim.keymap.set("n", "<Leader>ev", "<Cmd>edit $MYVIMRC<CR>")
-- Source the config file after edit
vim.keymap.set("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>")

-- Indenting Lines
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- Moving Lines
vim.keymap.set("n", "<A-j>", [[<Cmd>m .+1<CR>==]])
vim.keymap.set("n", "<A-k>", [[<Cmd>m .-2<CR>==]])
vim.keymap.set("v", "<A-j>", [[:'<,'>m '>+1<CR>gv=gv]])
vim.keymap.set("v", "<A-k>", [[:'<,'>m '<-2<CR>gv=gv]])
vim.keymap.set("i", "<A-j>", [[<Esc><Cmd>m .+1<CR>==gi]])
vim.keymap.set("i", "<A-k>", [[<Esc><Cmd>m .-2<CR>==gi]])

-- Pasting on top of selected text without saving the selected text
vim.keymap.set("v", "p", [["_dP]])
vim.keymap.del("s", "p")

-- Remove highlighting after searching
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>noh<CR>")

-- Plugin Management [<Leader>p - Packer]
vim.keymap.set("n", "<Leader>ps", "<Cmd>Lazy sync<CR>")

-- File explorer Keybindings [<Leader>n - netrw]
vim.keymap.set("n", "<Leader>n", "<Cmd>lua MiniFiles.open()<CR>")

-- Nvim-DAP Keybindings [<Leader>d - debugger]
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>dsv', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>dsi', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>dso', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dK', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

-- Fzf-lua Keybindings [<Leader>f - find]
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fo", "<Cmd>FzfLua oldfiles<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua help_tags<CR>")
vim.keymap.set("n", "<Leader>fg", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>FzfLua registers<CR>")
vim.keymap.set("n", "<Leader>fd", function ()
	-- Search Dotfiles with Telescope in any directory
	-- require("telescope.builtin").find_files({
	-- 	prompt_title = "< VimRC >",
	-- 	cwd = "~/.config/nvim",
	-- })
	-- or with Fzf-lua
	require('fzf-lua').files({
		prompt = "<VimRC> ❯ ",
		cwd = '~/.config/nvim',
	})
end)

-- C-/ to toggle comment in insert mode
vim.keymap.set("i", "<C-_>", "<Esc><Plug>(comment_toggle_linewise_current)gi")

-- Navigate through buffers [<Leader>b - buffers]
vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>")
vim.keymap.set("n", "<Leader>bp", "<Cmd>bprev<CR>")
vim.keymap.set("n", "<Leader>bx", "<Cmd>bwipeout<CR>")
-- Sort buffers by directory, language, or a custom criteria
-- vim.keymap.set("n", "<Leader>be", "<Cmd>BufferLineSortByExtension<CR>")
-- vim.keymap.set("n", "<Leader>bd", "<Cmd>BufferLineSortByDirectory<CR>")
-- vim.keymap.set("n", "<Leader>bbc", function ()
-- 	require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)
-- end)

-- LuaSnip Mappings
vim.keymap.set({"i", "s"}, [[<C-l>]], function ()
	local ls = require("luasnip")
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
vim.keymap.set({"i", "s"}, [[<C-h>]], function ()
	local ls = require("luasnip")
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)
vim.keymap.set({"i", "s"}, [[<C-k>]], function ()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)
vim.keymap.set({"i", "s"}, [[<C-j>]], function ()
	local ls = require("luasnip")
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)
