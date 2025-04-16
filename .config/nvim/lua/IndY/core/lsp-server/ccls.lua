local init_options = {
	compilationDatabaseDirectory = "build";
	index = {
		threads = 0;
	};
	clang = {
		excludeArgs = { "-frounding-math"} ;
	};
	cache = {
		directory = ".ccls-cache";
	};
	single_file_support = true;
}

return init_options
