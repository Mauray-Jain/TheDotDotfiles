-- Setup
return {
--	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	-- Ignore certain lines can be Lua regex or a fun() that returns that
	ignore = "^$", -- Ignoring empty lines
}
