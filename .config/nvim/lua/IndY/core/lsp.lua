-- Setup LSP
-- local lspconfig = require 'lspconfig'

local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<Leader>lsh', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>ll', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	vim.keymap.set('n', '<leader>lD', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, opts)
	-- vim.keymap.set('n', '<leader>lgo', vim.diagnostic.open_float, opts)
	-- vim.keymap.set('n', '<Leader>lgp', function() vim.diagnostic.goto_prev({float = true}) end, opts)
	-- vim.keymap.set('n', '<Leader>lgn', function() vim.diagnostic.goto_next({float = true}) end, opts)
	vim.keymap.set('n', '<leader>lgs', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', '<leader>lso', function() require('fzf-lua').lsp_document_symbols() end, opts)
	-- vim.keymap.set('n', '<leader>lso', function() require('telescope.builtin').lsp_document_symbols() end, opts) -- Not using telescope
end

local function lsp_autocommands(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		local lspGroup = vim.api.nvim_create_augroup("LspAutocmds", {clear = true})
		vim.api.nvim_create_autocmd("CursorHold", {
			group = lspGroup,
			desc = "Highlight the word",
			buffer = 0,
			callback = vim.lsp.buf.document_highlight
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = lspGroup,
			desc = "Clear all references",
			buffer = 0,
			callback = vim.lsp.buf.clear_references
		})
	end
end

local on_attach = function(client, bufnr)
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.api.nvim_create_user_command("Format", function (_) vim.lsp.buf.formatting() end, {})
	lsp_keymaps(bufnr)
	lsp_autocommands(client)
	require "lsp_signature".on_attach({
		bind = true,
		fix_pos = true,
		floating_window = false,
		hint_enable = true,
		hint_prefix = "● ",
		hint_scheme = "DiagnosticSignInfo",
	}, bufnr)
end

-- Various servers' setup
--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local opts = {
	on_attach = on_attach,
	capabilities = capabilities
}
-- local opts_copy = vim.deepcopy(opts)

local servers = {
	-- "arduino_language_server",
	-- "ccls",
	"clangd",
	"cssls",
	-- "denols",
	"gopls",
	-- "hls",
	-- "html",
	"jsonls",
	"lua_ls",
	"ocamllsp",
	"rust_analyzer",
	"pyright",
	"tailwindcss",
	"ts_ls",
	"zls",
}

for _, server in pairs(servers) do
	if server == "lua_ls" then
		local luals_opts = require("IndY.core.lsp-server.lua_ls")
		opts = vim.tbl_deep_extend("force", luals_opts, opts)
	elseif server == "ccls" then
		local ccls_opts = require("IndY.core.lsp-server.ccls")
		opts.init_options = ccls_opts
	elseif server == "jsonls" then
		local json_opts = require("IndY.core.lsp-server.jsonls")
		opts = vim.tbl_deep_extend("force", json_opts, opts)
	elseif server == "ts_ls" then
		opts.init_options = {lint = true}
		-- opts.root_dir = lspconfig.util.root_pattern("package.json")
	-- elseif server == "denols" then
	-- 	opts.init_options = {lint = true}
	-- 	opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
	elseif server == "html" then
		local capability = vim.lsp.protocol.make_client_capabilities()
		capability.textDocument.completion.completionItem.snippetSupport = true
		opts.capabilities = capability
	elseif server == "pyright" then
		vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
	-- elseif server == "tailwindcss" then
	-- 	opts.root_dir = lspconfig.util.root_pattern("tailwind.config.js")
	-- else
	-- 	opts = opts_copy
		-- local path = string.format("IndY.plugin-configs.lsp.lsp-server.%s", server)
		-- local err, server_opts = pcall(require, path)
		-- if err ~= true then
		-- 	print(server_opts)
		-- 	opts = vim.tbl_deep_extend("force", server_opts, opts)
		-- end
	end

	vim.lsp.enable(server)
	vim.lsp.config(server, opts)
end

-- Vim Diagnostics Setup
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = ' ',
			[vim.diagnostic.severity.WARN] = ' ',
			[vim.diagnostic.severity.HINT] = ' ',
			[vim.diagnostic.severity.INFO] = ' ',
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
			[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
			[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
			[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
			[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
			[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
		},
	},
	-- underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		-- focusable = false,
		border = "rounded",
		source = true,
		-- style = "minimal",
		-- header = "",
		-- prefix = "",
	},
})

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- Have borders when doing things
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = "rounded",
-- })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 	border = "rounded",
-- })
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, options, ...)
	options = options or {}
	options.border = options.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, options, ...)
end
