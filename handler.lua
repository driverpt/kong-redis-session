-- Extending the Base Plugin handler is optional, as there is no real
-- concept of interface in Lua, but the Base Plugin handler's methods
-- can be called from your child implementation and will print logs
-- in your `error.log` file (where all logs are printed).
local BasePlugin = require "kong.plugins.base_plugin"
local RedisSession = BasePlugin:extend()

local header_filter = require "kong.plugins.redis-session.header_filter"

-- Your plugin handler's constructor. If you are extending the
-- Base Plugin handler, it's only role is to instanciate itself
-- with a name. The name is your plugin name as it will be printed in the logs.
function RedisSession:new()
  RedisSession.super.new(self, "redis-session")
end

function RedisSession:access(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  RedisSession.super.access(self)
  
  header_filter.execute(config, ngx)
end

return RedisSession