package = "kong-redis-session"
version = "0.0.1-0"
source = {
  url = "git://github.com/driverpt/kong-redis-session"
}
description = {
  summary = "A Kong plugin that translates a Session Cookie to Authorization",
  license = "Apache V2"
}
dependencies = {
  "lua ~> 5.1",
  "lua-resty-cookie ~> 0.1.0"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.redis-session.handler"] = "handler.lua",
    ["kong.plugins.redis-session.schema"] = "schema.lua",
    ["kong.plugins.redis-session.header_filter"] = "header_filter",
  }
}
