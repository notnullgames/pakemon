local StateCredit = {}

local camera
local offset

local song = love.audio.newSource("plugins/credits/assets/strobe_-_android_assembled.xm", "stream")
song:setLooping(true)

-- this shows at bottom of credits
local endMessage = [[










Press B to go back.


]]

function StateCredit:enter()
  offset = 0
  camera = Camera(160, 0)
  song:play()
end

function StateCredit:update(dt)
  local height = getTextSize(plugins.credits.credits .. endMessage, 270)

  -- stop scrolling when it hits height
  offset = offset + (dt * 20)
  if offset < height then
    camera:move(0, dt * 20)
  end
end

function StateCredit:pressed(button)
  if button == "b" then
    song:stop()
    Gamestate.switch(StateMainMenu)
  end
end

function StateCredit:draw()
  camera:attach()
  love.graphics.printf("Pakémon", FontHeader, 10, 0, 300, "center")
  love.graphics.printf(plugins.credits.credits .. endMessage, FontBasic, 0, 30, 300, "center")
  camera:detach()
end

return StateCredit