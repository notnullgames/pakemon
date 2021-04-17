local socket = require "socket.http"
local ltn12 = require "ltn12"

-- make a http request
-- options is a table (like { proxy="host:port"} )
local function http(url, options)
  options = options or {}
  options.url = url
  local result_table = {}
  options.sink = ltn12.sink.table(result_table)
  local client,r,c,h = socket.request(options)
  return table.concat(result_table)
end

return http