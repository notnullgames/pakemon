local StateWelcome = {}

-- do your setup here
function StateWelcome:enter(dt)
end

-- do your updates here
function StateWelcome:update(dt)
end

-- do your draw calls here
function StateWelcome:draw()
  love.graphics.setFont(FontHeader)
  love.graphics.print("PUT WELCOME MESAGE HERE", 65, 100)
end

-- do your input-handling here
function StateWelcome:pressed(button)
  if button == "b" then
    Gamestate.switch(StateMainMenu)
  end
end

return StateWelcome