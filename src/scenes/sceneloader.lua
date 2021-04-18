-- this is just a simple scene-loader, so you can drag a scene (lua) file onto the window to test
-- press F11

local SceneSceneLoader = {}

local patchy = require("lib.patchy")

local rpg = patchy.load("assets/rpg.9.png")
local sound_move = love.audio.newSource("assets/move.wav", "static")
local sound_ok = love.audio.newSource("assets/ok.wav", "static")
local sound_back = love.audio.newSource("assets/back.wav", "static")
local pointer = love.graphics.newImage("assets/pointer.png")

local files
local current_selection

-- called when this loads
function SceneSceneLoader:load()
  current_selection = 1
  files = {}
  local fl = love.filesystem.getDirectoryItems("scenes")
  for f,file in pairs(fl) do
    local name = file:gsub('.lua$','')
    if name and name ~= 'template' and name ~= 'sceneloader' then
      table.insert(files, name)
    end
  end
end

-- called when a button is pressed
function SceneSceneLoader:pressed(button)
  if button == "a" then
    sound_move:stop()
    sound_ok:play()
    set_current_scene(files[current_selection])
  end
  if button == "b" then
    sound_back:play()
    set_current_scene("intro")
  end

  if button == 'down' then
    sound_move:stop()
    sound_move:play()
    current_selection = current_selection + 1
  end
  
  if button == 'up' then
    sound_move:stop()
    sound_move:play()
    current_selection = current_selection - 1
  end
  
  if current_selection < 1 then
    current_selection = #files
  elseif current_selection > #files then
    current_selection = 1
  end
end

-- callled in main draw loop
function SceneSceneLoader:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )

  local cx, cy, cw, ch = rpg:draw(10, 10, 300, 35 + (#files * 14))  
  love.graphics.printf("Please choose the scene:", cx, cy + 5, cw, "center")
  for f,name in pairs(files) do
    love.graphics.printf(name, cx + 30, 20 + cy + ((f-1) * 14), cw)
  end
  love.graphics.draw(pointer, 20, 22 + cy + ((current_selection-1) * 14))
end

-- local lurker = require("lib.lurker")
-- lurker.preswap = function(f)
--   set_current_scene(gamescene_name)
-- end
-- function SceneSceneLoader:update()
--   lurker.update()
-- end

return SceneSceneLoader