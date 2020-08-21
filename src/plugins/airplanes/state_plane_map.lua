local StatePlaneMap = {}

local image

function StatePlaneMap:enter()
  image = httpGetMap({
    -- lat, long, alt, dir, hex
    { -122.6555, 45.60, 3000, 75, 'b4321' },
    { -122.680, 45, 4000, 175, 'b4321' },
    { -122.658, 45.50, 5000, 270, 'a1234' },
    { -122.6, 45.40, 2000, 15, 'a123456' }
  })
end

function StatePlaneMap:draw()
  if image then
    love.graphics.draw(image, 0, 0)
  end
end

function StatePlaneMap:pressed(button)
  if button == "b" then
    Gamestate.switch(StateMainMenu)
  end
end

return StatePlaneMap