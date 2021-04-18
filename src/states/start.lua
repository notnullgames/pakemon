-- this shows new/continue screen

local patchy = require("lib.patchy")

local rpg = patchy.load("assets/rpg.9.png")
local sound_move = love.audio.newSource("assets/move.wav", "static")
local sound_ok = love.audio.newSource("assets/ok.wav", "static")

local StateStart = {}

local hasContinue = false
local currentChoice = 0

function doContinue()
  set_current_state(PLAYER.state)
end

function doNew()
  PLAYER = { level = 0 }
  save_player()
  set_current_state("welcome")
end

-- called when this loads
function StateStart:load()
  load_player()
  hasContinue = PLAYER and PLAYER.level > 0
end

-- called when a button is pressed
function StateStart:pressed(button)
  if hasContinue then
    if button == "up" or button == "down" then
      sound_move:play()
      if currentChoice == 1 then
        currentChoice = 0
      else
        currentChoice = 1
      end
    end
    if button == "a" then
      sound_ok.play()
      if currentChoice == 0 then
        doContinue()
      else
        doNew()
      end
    end
  else
    if button == "a" then
      sound_ok.play()
      doNew()
    end
  end
end

-- callled in main draw loop
function StateStart:draw()
  love.graphics.setColor(1, 1, 1, 1)

  if hasContinue then
    rpg:draw(100, 86, 120, 65)
    love.graphics.printf("Continue", 130, 100, 320)
    love.graphics.printf("New Game", 130, 120, 320)
    love.graphics.print("-", 120, 100 + (currentChoice * 20))
  else
    rpg:draw(100, 95, 120, 55)
    love.graphics.printf("-  New Game", 0, 114, 320, "center")
  end
end


-- local lurker = require("lib.lurker")

-- lurker.preswap = function(f)
--   set_current_state(gamestate_name)
-- end

-- function StateStart:update()
--   lurker.update()
-- end

return StateStart
