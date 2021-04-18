-- this should be a welcome animation (start of new game)

local StateWelcome = {}

-- called when this loads
function StateWelcome:load()
end

-- called when some othe rstate is chosen
function StateWelcome:unload()
end

-- called to update logic
function StateWelcome:update(dt, totaltime)
end

-- called when a button is pressed
function StateWelcome:pressed(button)
end

-- called when a button is released
function StateWelcome:released(button)
end

-- callled in main draw loop
function StateWelcome:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf("Welcome Animation here", 0, 110, 320, "center")
end

return StateWelcome
