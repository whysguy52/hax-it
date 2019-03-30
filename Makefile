default: run

build:
	env LIBRARY_PATH="$(PWD)" crystal build src/hax_it.cr

run: build
	env LD_LIBRARY_PATH="$(PWD)" ./hax_it
