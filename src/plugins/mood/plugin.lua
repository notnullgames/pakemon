local MoodState = { mood = "happy" }

local image, animations

function MoodState:enter()
    image = love.graphics.newImage("assets/sprites1.png")
    local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
    animations = {
        sad = anim8.newAnimation(g(7,5, 8,5, 9,5), 0.5),
        happy = anim8.newAnimation(g(4,5, 6,5), 0.5)
    }
end

function MoodState:update(dt)
    animations[self.mood]:update(dt)
end

function MoodState:draw()
    love.graphics.push()
    love.graphics.scale(2, 2)
    animations[self.mood]:draw(image, 62, 25)
    love.graphics.pop()
    
    love.graphics.printf(self.mood, FontHeader, 0, 100, 320, "center")
end

return MoodState