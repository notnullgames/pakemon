local StateWelcome = {}

local logo = love.graphics.newImage("plugins/intro/logo-white.png")
local voice = love.audio.newSource("plugins/intro/notnullgames.ogg", "stream")

logo:setFilter('nearest', 'nearest')

-- do your setup here
function StateWelcome:enter(dt)
  voice:play()
  Timer.after(3, function() Gamestate.switch(StateCity) end )
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
  if button == "b" or button == "a" or button == "start" or button == "start" then
    Gamestate.switch(StateCity)
  end
end

return StateWelcome