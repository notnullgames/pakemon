local MoodState = { mood = "happy" }

function MoodState:draw()
    -- TODO: put your code here that draws an animation based on self.mood
    love.graphics.print(self.mood, 100, 100)
end

return MoodState