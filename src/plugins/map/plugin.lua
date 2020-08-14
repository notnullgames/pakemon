local StateMapDemo = {}

local map = require "plugins.map.map"

local image

function StateMapDemo:enter()
  image = map:getMapImage({
    -- lat, long, alt, dir, hex
    { -122.6555, 45.60, 3000, 90, 'b4321' },
    { -122.658, 45.50, 4000, 270, 'a1234' },
    { -122.6, 45.40, 2000, 180, 'a123456' }
  })
end

function StateMapDemo:draw()
  if image then
    love.graphics.draw(image, 0, 0)
  end
end

function StateMapDemo:pressed(button)
  if button == "b" then
    Gamestate.switch(StateMenu)
  end
end

return StateMapDemo