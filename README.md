# kong-redis-session
Kong plugin that translates a Session Cookie to Authorization header. e.g.: Session Cookie -> JWT

## Configuration

 * **cookie_name** - Cookie Name that contains the Session ID
 * **redis_session_prefix** - Default Redis Prefix for keys, e.g.: my:session:namespace
 * **redis_host** - Redis Hostname or IP
 * **redis_port** - Redis Port (defaults to 6379)
 * **redis_password** - Redis Password (not required). **Always set a password for Production Environments**
 * **redis_timeout** - Redis Client Timeout for all connections (defaults to 2 seconds)
 * **hash_key** - Key inside the Hash containing the Authorization Token value (defaults to JWT)

| Key        | Default Value  | Required  |
| ------------- |-------------| ----- |
| cookie_name      | SESSION  | No |
| redis_session_prefix      |       |   No |
| redis_host |       | Yes |
| redis_port |  6379     | No |
| redis_password |       | No |
| redis_timeout | 2000 | No |
| hash_key | JWT | No |


### Example

```
curl -X POST http://kong:8001/apis/{api}/plugins \
    --data "name=kong-redis-session" \
    --data "config.cookie_name=<cookie_name>" \
    --data "config.redis_session_prefix=<prefix>" \
    --data "config.redis_host=<redis_host>" \
    --data "config.redis_port=<redis_port>" \
    --data "config.redis_password=<redis_password>" \
    --data "config.redis_timeout=123456" \
    --data "config.hash_key=JWT"
```
