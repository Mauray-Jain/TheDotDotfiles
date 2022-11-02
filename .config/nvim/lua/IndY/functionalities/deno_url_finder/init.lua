-- Find the correct URL for deno.json schema acc. to version
local deno_url_finder = function ()
	if vim.fn.executable("deno") == 0 then
		return "https://deno.land/x/deno/cli/schemas/config-file.v1.json"
	end
	local deno = vim.fn.system("deno --version")
	local deno_ver = string.match(deno, "%d%p%d%d%p%d") -- Pattern liable to change for different versions
	return string.format([[https://deno.land/x/deno@v%s/cli/schemas/config-file.v1.json]], deno_ver)
end

local deno_url = deno_url_finder()

return deno_url
