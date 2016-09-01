local redis = require "resty.redis"

local _M = {}

function _M.execute(conf, ngx)
  local cookie = require "resty.cookie"

  local ngx_headers = ngx.req.get_headers()
  local ck = cookie:new()
  local session, err = ck:get(conf.cookie_name)
  ngx.log(ngx.ERR, session)
  if not session then
    ngx.log(ngx.ERR, err)
    return
  end
  
  local red = redis:new()
  red:set_timeout(conf.redis_timeout)
  local ok, err = red:connect(conf.redis_host, conf.redis_port)
  if not ok then
    ngx.log(ngx.ERR, "failed to connect to Redis: ", err)
    return
  end

  if conf.redis_password and conf.redis_password ~= "" then
    local ok, err = red:auth(conf.redis_password)
    if not ok then
      ngx.log(ngx.ERR, "failed to connect to Redis: ", err)
      return
    end
  end
  
  local cache_key = session
  if string.len(conf.redis_session_prefix) > 0 then
    cache_key = conf.redis_session_prefix .. ":" .. cache_key
  end
  
  local jwt, err = red:get(cache_key)
  if err then
    ngx.log(ngx.ERR, "error while fetching redis key: ", err)
    return
  end
  
  local authorization_header = ngx.header["Authorization"]
  print(authorization_header)
  if not authorization_header then
    ngx.req.set_header("Authorization", "Bearer " .. jwt)
  end
end

return _M