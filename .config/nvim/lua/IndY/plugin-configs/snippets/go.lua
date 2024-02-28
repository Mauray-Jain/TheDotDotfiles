-- https://www.youtube.com/watch?v=aNWx-ym7jjI
local ls = require("luasnip")
local snip = ls.snippet
local snipn = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local choice = ls.choice_node
local dyn = ls.dynamic_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text

local transforms = {
  int = function(_, _)
    return text "0"
  end,

  bool = function(_, _)
    return text "false"
  end,

  string = function(_, _)
    return text [[""]]
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return choice(info.index, {
        text(info.err_name),
        text(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
      })
    else
      return text "err"
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text_param)
    return string.find(text_param, "*", 1, true) ~= nil
  end] = function(_, _)
    return text "nil"
  end,
}

local transform = function(str, info)
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == str
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, str, info) then
      return result(str, info)
    end
  end

  return text(str)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, text { ", " })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local str = get_node_text(node, 0)
    return { transform(str, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    print "Not inside of a function"
    return text ""
  end

  local query = vim.treesitter.query.parse(
    "go",
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local go_ret_vals = function(args)
  return snipn(
    nil,
    go_result_type {
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    }
  )
end

ls.add_snippets("go", {
	snip(
		"efi",
		fmta(
			[[
<val>, <err> := <f>
if <err_same> != nil {
	return <result>
}
<finish>
]],
			{
				val = insert(1),
				err = insert(2, "err"),
				f = insert(3),
				err_same = rep(2),
				result = dyn(4, go_ret_vals, { 2, 3 }),
				finish = insert(0),
			}
		)
	),
})
