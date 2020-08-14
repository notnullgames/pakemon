local StateMapDemo = {}

local map = require "plugins.map.map"

local image

function StateMapDemo:enter()
  image = map:getMapImage({
    { -122.6555, 45.5046 },
    { -122.6555, 45.50 }
  })
end

function StateMapDemo:draw()
  if image then
    love.graphics.draw(image, 0, 0)
  end
end

return StateMapDemo