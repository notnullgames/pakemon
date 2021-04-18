-- this is a library to interact with backend trainer UDP 

local socket = require("socket")
local json = require("lib.json")

local udp 

function trainer(...)
  -- lazy-load
  if udp == nil then
    udp = socket.udp()
    udp:settimeout(1)
    -- TODO: this should come from env-var or something
    udp:setpeername("127.0.0.1", 12345)
  end
  udp:send(json.encode(arg))
  return json.decode(udp:receive())
end

return trainer