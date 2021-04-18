-- this shows how to interact with trainer

local trainer = require('lib.trainer')

local SceneTrainerTest = {}

local updaterate = 4 -- how long to wait, in seconds, before requesting an update

local response = "Run your local trainer to test."
local t = 0

-- called when this loads
function SceneTrainerTest:load()
end

-- called when some othe rscene is chosen
function SceneTrainerTest:unload()
end

-- called to update logic
function SceneTrainerTest:update(dt, totaltime)
  -- you don't want to overload the server, so don't do requests on every frame
  t = t + dt
  if  t > updaterate then
    response = trainer("hello", "Pakemon" .. os.time()).msg
    t=t-updaterate -- set t for the next round
  end
end

-- called when a button is pressed
function SceneTrainerTest:pressed(button)
end

-- called when a button is released
function SceneTrainerTest:released(button)
end

-- callled in main draw loop
function SceneTrainerTest:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
  love.graphics.printf(response, 0, 110, 320, "center")
end

return SceneTrainerTest
