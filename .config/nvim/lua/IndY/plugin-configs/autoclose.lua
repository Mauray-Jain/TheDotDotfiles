local lisp_langs = { "lisp", "scheme", "clojure", "fennel" }
return {
	keys = {
		["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = lisp_langs },
		["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = lisp_langs },
	},
	options = {
		pair_spaces = true,
	},
}
