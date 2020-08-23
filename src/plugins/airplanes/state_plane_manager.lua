-- this is the top-level manager that checks if internet is available for maps

local StatePlaneManager = {}

function StatePlaneManager:draw()
    love.graphics.setFont(FontBasic)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Not setup yet. \nNeed to tie map + menu together, here.", 50, 90, 200, "center")

end

function StatePlaneManager:pressed(button)
    if button == 'b' then
        Gamestate.switch(StateMainMenu)
    end
end

return StatePlaneManager