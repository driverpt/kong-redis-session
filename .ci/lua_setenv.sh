export PATH=${PATH}:$HOME/.lua:$HOME/.local/bin:${TRAVIS_BUILD_DIR}/install/luarocks/bin
bash .ci/lua_setup.sh
eval `$HOME/.lua/luarocks path`