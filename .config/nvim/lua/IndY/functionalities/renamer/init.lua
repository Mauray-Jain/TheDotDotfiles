local function renamer()
	vim.ui.input({
		prompt = "New Name",
		default = ""
	}, function (input)
		vim.lsp.buf.rename(input)
	end)
end

return renamer
