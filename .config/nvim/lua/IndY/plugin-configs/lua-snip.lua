-- luasnip setup
local ls = require("luasnip")
local types = require("luasnip.util.types")
-- some shorthands...
local snip = ls.snippet -- It is a snippet creator, syntax: snip(<trigger>, <nodes>)
-- local snip_node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node -- To insert something, syntax: insert(<position>, <placehoder>)
local func = ls.function_node -- For computing something before adding it, syntax: func(<function that returns string>, {arguments for funtion})
-- local choice = ls.choice_node -- For a choice node, syntax: choice(<position>, {list, of, choices})
-- local dynamic = ls.dynamic_node
-- local restore = ls.restore_node
-- local lambda = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep -- To repeat something, syntax: rep(<position>)
-- local partial = require("luasnip.extras").partial
-- local match = require("luasnip.extras").match
-- local nonempty = require("luasnip.extras").nonempty
-- local dyn_lambda = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt -- Takes a format string and nodes, syntax: fmt(<string>, {nodes})
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

ls.config.set_config {
	-- Helps to jump back to last snippet by keeping tham in history
	history = true,
	-- Helps to update as we type, useful for dynamic snippets
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { {"", "Error"} },
			},
		},
	},
}

ls.add_snippets(nil, {
	sh = {
		-- If in sh
		snip("if-modified",{
			text("if [[ "),
			insert(1, "condition"),
			text(" ]]; then"),
			text({"", "\t"}),
			insert(2, "body"),
			text({"", "fi"}),
			insert(0)
		}),
		-- If-else in sh
		snip("if-else",{
			text("if [[ "),
			insert(1, "condition"),
			text(" ]]; then"),
			text({"", "\t"}),
			insert(2, "body"),
			text({"", "else"}),
			text({"", "\t"}),
			insert(3, "body"),
			text({"", "fi"}),
			insert(0)
		}),
		-- If-elseif-else in sh
		snip("if-elseif-else",{
			text("if [[ "),
			insert(1, "condition"),
			text(" ]]; then"),
			text({"", "\t"}),
			insert(2, "body"),
			text({"", "elif [[ "}),
			insert(3, "condition"),
			text(" ]]; then"),
			text({"", "\t"}),
			insert(4, "body"),
			text({"", "else"}),
			text({"", "\t"}),
			insert(5, "body"),
			text({"", "fi"}),
			insert(0)
		}),
	},
	lua = {
		-- 	snip("req", fmt("local {} = require('{}')", { insert(1, "default"), rep(1) })) -- Example of fmt and rep
		-- Smart require
		snip("require", fmt([[local {} = require "{}"]], {
			func(function (import_name)
				local parts = vim.split(import_name[1][1], ".")
				return parts[#parts] or ""
				end, {1}), -- 1 here stands for insert node
			insert(1)
		})),
	}
});

ls.add_snippets("html", {
	-- HTML BoilerPlate
	snip("!", fmt([[
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width={}, initial-scale={}">
			<title>{}</title>
		</head>
		<body>
			{}
		</body>
	</html>
	]], {
		insert(1, "device-width"),
		insert(2, "1.0"),
		insert(3, "Document"),
		insert(0)})),
})

ls.add_snippets("c", {
	snip("bareMin", fmt([[
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[]){{
	{}
	return 0;
}}
		]], {insert(0)}))
})

ls.add_snippets("zig", {
	snip("bareMin", fmt([[
const std = @import("std");

pub fn main() !void {{
	{}
}}
		]], {insert(0)}))
})

-- VSCode style snippets can be defined as
-- ls.parser.parse_snippet("trigger", "Snippet")
-- Always call after ls.snippets
require("luasnip.loaders.from_vscode").lazy_load() -- Loading of Friendly Snippets
