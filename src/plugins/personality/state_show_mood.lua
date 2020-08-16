-- state for showing current personality/mood

local StateShowMood = {}

function StateShowMood:draw()
  love.graphics.push()
  love.graphics.scale(4, 4)
  plugins.personality:drawMe(23.5,10)
  love.graphics.pop()
  love.graphics.printf(plugins.personality.mood, FontHeader, 0, 165, 320, "center")
  love.graphics.printf(plugins.personality.moodwhy or "", FontBasic, 0, 185, 320, "center")
end

function StateShowMood:pressed(button)
  if button == "b" then
    Gamestate.switch(self.oldGs or StateMainMenu)
  end
end

return StateShowMood