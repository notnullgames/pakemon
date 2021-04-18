local SceneTemplate = {}

-- this kills performance, but is good for lining things up
local RELOAD = true

-- called when this loads
function SceneTemplate:load()
end

-- called when some othe rscene is chosen
function SceneTemplate:unload()
end

-- called to update logic
function SceneTemplate:update(dt, totaltime)
end

if RELOAD then
  local lurker = require("lib.lurker")
  
  lurker.preswap = function(f)
    set_current_scene(gamescene_name)
  end

  function SceneTemplate:update()
    lurker.update()
  end
end

-- called when a button is pressed
function SceneTemplate:pressed(button)
end

-- called when a button is released
function SceneTemplate:released(button)
end

-- callled in main draw loop
function SceneTemplate:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
end

return SceneTemplate
