local StatePlaneMap = {}

local image

function StatePlaneMap:enter()
  image = httpGetMap({
    { 45.215, -122.626, 4000, 90, "a9426f" },
    { 45.643, -122.734, 3000, 45, "a8881e" },
    { 45.017, -122.532, 2000, 75, "aaf183" },
    { 45.441, -122.428, 3000, 180, "abf396" },
    { 45.913, -122.633, 4000, 15, "a037b2" },
    { 45.643, -122.570, 2000, 45, "a1388c" },
    { 45.923, -122.848, 4000, 0, "a6ff8d" },
    { 45.376, -122.759, 3000, 90, "a9f7b0" },
    { 45.287, -122.543, 4000, 15, "a85931" }
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