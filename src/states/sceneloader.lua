-- this is just a simple scene-loader, so you can drag a scene (lua) file onto the window to test

local StateSceneLoader = {}

local files = {}
local current_selection = 1

-- called to update logic
function StateSceneLoader:update(dt, totaltime)
  files = {}
  local fl = love.filesystem.getDirectoryItems("states")
  for f,file in pairs(fl) do
    local name = file:gsub('.lua$','')
    if name and name ~= 'template' and name ~= 'sceneloader' then
      table.insert(files, name)
    end
  end
end

-- called when a button is pressed
function StateSceneLoader:pressed(button)
  if button == "a" then
    set_current_state(files[current_selection])
  end
  if button == "b" then
    set_current_state("intro")
  end

  if button == 'down' then
    current_selection = current_selection + 1
  end
  
  if button == 'up' then
    current_selection = current_selection - 1
  end
  
  if current_selection < 1 then
    current_selection = #files
  elseif current_selection > #files then
    current_selection = 1
  end
end

-- callled in main draw loop
function StateSceneLoader:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
  
  love.graphics.printf("Please choose the scene:", 20, 20, 300)
  for f,name in pairs(files) do
    love.graphics.printf(name, 40, 40 + ((f-1) * 14), 300)
  end
  love.graphics.printf('-', 20, 40 + ((current_selection-1) * 14), 300)
end

return StateSceneLoader