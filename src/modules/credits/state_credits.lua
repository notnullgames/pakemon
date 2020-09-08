local StateCredits = { }

local endMessage = [[










Press B to go back.


]]

local camera
local offset

local song = love.audio.newSource("modules/credits/assets/strobe_-_android_assembled.xm", "stream")
song:setLooping(true)

local title = love.graphics.newImage("modules/intro/assets/title.png")

function StateCredits:enter()
  offset = 0
  camera = Camera(160, 0)
  song:play()
end

function StateCredits:update(dt)
  local height = getTextSize(pakemon.credits.text .. endMessage, 270)

  -- stop scrolling when it hits height
  offset = offset + (dt * 20)
  if offset < height then
    camera:move(0, dt * 20)
  end
end

function StateCredits:pressed(button)
  if button == "b" then
    song:stop()
    Gamestate.switch(StateMainMenu)
  end
end

function StateCredits:draw()
  camera:attach()
  love.graphics.draw(title, 80, -30, 0, .06, .06 )
  love.graphics.setColor(1,1,1,1)
  love.graphics.printf(pakemon.credits.text .. endMessage, FontDefault, 0, 30, 300, "center")
  camera:detach()
end

return StateCredits