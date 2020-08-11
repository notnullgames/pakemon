local MoodState = { mood = "happy" }

function MoodState:draw()
    -- TODO: put your code here that draws an animation based on self.mood
    love.graphics.printf(self.mood, FontHeader, 0, 100, 320, "center")
end

return MoodState