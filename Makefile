DEV_ROCKS = busted luacheck lua-llthreads2
BUSTED_ARGS ?= -o gtest -v --exclude-tags=ci
TEST_CMD ?= busted $(BUSTED_ARGS)
PLUGIN_NAME := kong-plugin-redis-session

.PHONY: install uninstall dev lint test test-integration test-all clean

dev:
	@for rock in $(DEV_ROCKS) ; do \
		if ! command -v $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock --local; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;

lint:
	@luacheck -q . \
						--std 'ngx_lua+busted' \
						--globals '_KONG' \
						--globals 'ngx' \
						--globals 'assert' \
						--no-redefined \
						--no-unused-args

install:
	luarocks make $(PLUGIN_NAME)-*.rockspec

install-dev: dev
	luarocks make --tree lua_modules $(PLUGIN_NAME)-*.rockspec

uninstall:
	luarocks remove $(PLUGIN_NAME)-*.rockspec

install-dev:
	luarocks make --tree lua_modules $(PLUGIN_NAME)-*.rockspec

test: install-dev
	$(TEST_CMD) $(current_dir)spec/01-unit

test-integration: install-dev
	$(TEST_CMD) $(current_dir)spec/02-integration

test-all: install-dev
	$(TEST_CMD) $(current_dir)spec/

clean:
	@echo "removing $(PLUGIN_NAME)"
	-@luarocks remove --tree lua_modules $(PLUGIN_NAME)-*.rockspec >/dev/null 2>&1 ||: