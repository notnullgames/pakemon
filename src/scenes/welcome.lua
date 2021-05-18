-- this should be a welcome animation (start of new game)

local song = love.audio.newSource("assets/pokemon.xm", "static")

local SceneWelcome = {}

-- called when this loads
function SceneWelcome:load()
  song:play()
end

-- called when some othe rscene is chosen
function SceneWelcome:unload()
  song:stop()
end

-- called to update logic
function SceneWelcome:update(dt, totaltime)
end

-- called when a button is pressed
function SceneWelcome:pressed(button)
end

-- called when a button is released
function SceneWelcome:released(button)
end

-- callled in main draw loop
function SceneWelcome:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
  love.graphics.clear()
  love.graphics.printf("Welcome Animation here", 0, 110, 320, "center")
end

return SceneWelcome
