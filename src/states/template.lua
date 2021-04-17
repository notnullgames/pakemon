local StateTemplate = {}

-- called when this loads
function StateTemplate:load()
end

-- called when some othe rstate is chosen
function StateTemplate:unload()
end

-- called to update logic
function StateTemplate:update(dt, totaltime)
end

-- called when a button is pressed
function StateTemplate:pressed(button)
end

-- called when a button is released
function StateTemplate:released(button)
end

-- callled in main draw loop
function StateTemplate:draw()
end

return StateTemplate
