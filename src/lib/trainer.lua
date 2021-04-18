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
  local cmd = ...
  local args = {select(2, ...)}
  print("trainer")
  print(table.show(cmd, "cmd"))
  print(table.show(args, "args"))
  udp:send(json.encode({ cmd = cmd, args = args }))
  local out = json.decode(udp:receive())
  -- close the connection to free up port-usage
  udp:close()
  udp = nil
  return out
end

return trainer