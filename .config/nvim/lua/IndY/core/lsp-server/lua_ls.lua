-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- return {
--
-- 	on_init = function(client)
-- 		if not client.workspace_folders then
-- 			return
-- 		end
-- 		local path = client.workspace_folders[1].name
-- 		if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
-- 			return
-- 		end
--
-- 		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using
-- 				-- (most likely LuaJIT in the case of Neovim)
-- 				version = 'LuaJIT'
-- 			},
-- 			-- Make the server aware of Neovim runtime files
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					-- Depending on the usage, you might want to add additional paths here.
-- 					-- "${3rd}/luv/library"
-- 					-- "${3rd}/busted/library",
-- 				}
-- 				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
-- 				-- library = vim.api.nvim_get_runtime_file("", true)
-- 			}
-- 		})
-- 	end,
-- 	settings = {
-- 		Lua = {
-- 			workspace = {
-- 				library = {
-- 					"/usr/share/awesome/lib",
-- 				}
-- 			},
-- 			diagnostics = {
-- 				globals = {
-- 					"awesome",
-- 					"client",
-- 					"root",
-- 				}
-- 			}
-- 		}
-- 	}


	-- on_init = function(client)
	-- 	local path = client.workspace_folders[1].name
	-- 	if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
	-- 		client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
	-- 			Lua = {
	-- 				runtime = {
	-- 					-- Tell the language server which version of Lua you're using
	-- 					-- (most likely LuaJIT in the case of Neovim)
	-- 					version = 'LuaJIT'
	-- 				},
	-- 				-- Make the server aware of Neovim runtime files
	-- 				workspace = {
	-- 					checkThirdParty = false,
	-- 					library = {
	-- 						vim.env.VIMRUNTIME
	-- 						-- "${3rd}/luv/library"
	-- 						-- "${3rd}/busted/library",
	-- 					}
	-- 					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
	-- 					-- library = vim.api.nvim_get_runtime_file("", true)
	-- 				}
	-- 			}
	-- 		})
	--
	-- 		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	-- 	end
	-- 	return true
	-- end,
-- }

return {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
		Lua = {
			workspace = {
				library = {
					"/usr/share/awesome/lib",
				}
			},
			diagnostics = {
				globals = {
					"awesome",
					"client",
					"root",
				}
			}
		}
  }
}
