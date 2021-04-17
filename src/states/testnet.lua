local socket = require("socket")

local udp

local StateTestNet = {}

-- called when this loads
function StateTestNet:load()
  udp = socket.udp()
  udp:settimeout(0) -- 0 seems to not be working right to make it non-blocking
  udp:setpeername('127.0.0.1', 12345)
  udp:send("pakemon says sup")
end

-- called when some othe rstate is chosen
function StateTestNet:unload()
end

-- called to update logic
function StateTestNet:update(dt, totaltime)
  repeat
    data, err = udp:receive()
    if data then
      print("Received from server: " .. data)
    end
  until not data
end

-- called when a button is pressed
function StateTestNet:pressed(button)
end

-- called when a button is released
function StateTestNet:released(button)
end

-- callled in main draw loop
function StateTestNet:draw()
  love.graphics.setColor( 1, 1, 1, 1 )
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
  
  love.graphics.printf("Check your socket-server.", 0,100, 320, "center")
end

return StateTestNet
