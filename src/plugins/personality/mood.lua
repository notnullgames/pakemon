-- state for showing current personality/mood

local StateShowMood = {}

function StateShowMood:draw()
  love.graphics.push()
  love.graphics.scale(4, 4)
  personality:drawMe(23.5,10)
  love.graphics.pop()
  love.graphics.printf(personality.mood, FontHeader, 0, 165, 320, "center")
  love.graphics.printf(personality.moodwhy, FontBasic, 0, 185, 320, "center")
end

return StateShowMood