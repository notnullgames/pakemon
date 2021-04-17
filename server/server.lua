-- this is a demo UDP socket-server

local socket = require "socket"
local udp = socket.udp()

udp:settimeout(0)
udp:setsockname('0.0.0.0', 12345)

local running = true

print "Starting UDP socket-server on port 12345"
while running do
  data, msg_or_ip, port_or_nil = udp:receivefrom()
  if data then
    print("RECEIVED" .. data .. msg_or_ip)
  end
  socket.sleep(0.01)
end