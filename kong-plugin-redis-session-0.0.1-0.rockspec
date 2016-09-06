package = "kong-plugin-redis-session"
version = "0.0.1-0"
source = {
  url = "git://github.com/driverpt/kong-redis-session"
}
description = {
  summary = "A Kong plugin that translates a Session Cookie to Authorization",
  license = "Apache V2",
  homepage = "https://github.com/driverpt/kong-redis-session"
}
dependencies = {
  "lua ~> 5.1",
  "lua-resty-cookie ~> 0.1.0"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.redis-session.handler"] = "handler.lua",
    ["kong.plugins.redis-session.schema"] = "schema.lua"
  }
}