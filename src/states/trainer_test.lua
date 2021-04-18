local trainer = require('lib.trainer')

local StateTrainerTest = {}

local updaterate = 4 -- how long to wait, in seconds, before requesting an update

local response = ""
local t = 0

-- called when this loads
function StateTrainerTest:load()
  response = trainer("hello", "Pakemon" .. os.time())
end

-- called when some othe rstate is chosen
function StateTrainerTest:unload()
end

-- called to update logic
function StateTrainerTest:update(dt, totaltime)
  -- you don't want to overload the server, so don't do requests on every frame
  t = t + dt
  if  t > updaterate then
    response = trainer("hello", "Pakemon" .. os.time()).msg
    t=t-updaterate -- set t for the next round
  end
end

-- called when a button is pressed
function StateTrainerTest:pressed(button)
end

-- called when a button is released
function StateTrainerTest:released(button)
end

-- callled in main draw loop
function StateTrainerTest:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf(response, 0, 110, 320, "center")
end

return StateTrainerTest
