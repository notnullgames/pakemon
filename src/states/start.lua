-- this shows new/continue screen

local StateStart = {}

local hasContinue = false
local currentChoice = 0

function doContine()
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
      if currentChoice == 1 then
        currentChoice = 0
      else
        currentChoice = 1
      end
    end
    if button == "a" then
      if currentChoice == 0 then
        doContine()
      else
        doNew()
      end
    end
  else
    if button == "a" then
      doNew()
    end
  end
end

-- callled in main draw loop
function StateStart:draw()
  love.graphics.setColor(1, 1, 1, 1)
  if hasContinue then
    love.graphics.printf("Continue", 130, 100, 320)
    love.graphics.printf("New Game", 130, 120, 320)
    love.graphics.print("-", 120, 100 + (currentChoice * 20))
  else
    love.graphics.printf("- New Game", 0, 110, 320, "center")
  end
end

return StateStart
