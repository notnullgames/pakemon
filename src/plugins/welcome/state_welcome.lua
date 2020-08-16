local StateWelcome = {}

local logo = love.graphics.newImage("plugins/welcome/logo-white.png")
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
  love.graphics.draw( logo, 50, 10)
end

-- do your input-handling here
function StateWelcome:pressed(button)
  if button == "b" or button == "a" or button == "start" then
    Gamestate.switch(StateMainMenu)
  end
end

return StateWelcome