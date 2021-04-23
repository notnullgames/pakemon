-- this is a library to interact with backend trainer UDP 

local socket = require("socket")

function trainer(...)
  local tcp = assert(socket.tcp())
  tcp:settimeout(0)
  tcp:connect('127.0.0.1', 12345)
  tcp:send(table.concat({...}, "☺").."\n\n")
  local out = {}
  while true do
      local partial, status = tcp:receive()
      if not partial then
        return status
      end
      table.insert(out, partial)
      if status == "closed" then break end
  end
  tcp:close()
  return nil, table.concat(out)
end

return trainer