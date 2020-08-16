local StateWelcome = {}

local logo = love.graphics.newImage("plugins/welcome/notnullgames.png")
local voice = love.audio.newSource("plugins/welcome/notnullgames.ogg", "stream")

logo:setFilter('nearest', 'nearest')

-- do your setup here
function StateWelcome:enter(dt)
  voice:play()
end

-- do your updates here
function StateWelcome:update(dt)
end

-- do your draw calls here
function StateWelcome:draw()
  love.graphics.push()
  love.graphics.scale(4, 4)
  love.graphics.draw( logo, 8.5, -2)
  love.graphics.pop()
end

-- do your input-handling here
function StateWelcome:pressed(button)
  if button == "b" then
    Gamestate.switch(StateMainMenu)
  end
end

return StateWelcome