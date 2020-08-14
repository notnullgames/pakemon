local StateMapDemo = {}

local map = require "plugins.map.map"

local image

function StateMapDemo:enter()
  image = map:getMapImage({
    -- lat, long, alt, dir, hex
    { -122.6555, 45.5046, 3000, 1.5, 'b4321' },
    { -122.6555, 45.50, 4000, 1.5, 'a1234' },
    { -122.65, 45.40, 2000, 1.5, 'a123456' }
  })
end

function StateMapDemo:draw()
  if image then
    love.graphics.draw(image, 0, 0)
  end
end

return StateMapDemo