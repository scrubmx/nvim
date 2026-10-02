.PHONY: test

test:
	nvim --headless -i NONE '+lua dofile("tests/mappings.lua")'
