local CreditState = {}

local camera
local offset

local song = love.audio.newSource("assets/strobe_-_android_assembled.xm", "stream")

local credits = [[
was made possible by the labor of love of many people.


Konsumer & Clout made a lot of the code & graphics.

Love2D provides the input/sound/graphics engine.

The cool song you are hearing right now is by Strobe. It's called "Android Assembled". Go check out their other awesome work on the mod archive.

TODO: add all the other things that get used in this app.

pokemon animations came from here: https://imgur.com/a/SOiOU









Press B to go back.
]]

function CreditState:enter()
  offset = 0
  camera = Camera(160, 0)
  song:play()
end

function CreditState:update(dt)
  offset = offset + (dt * 20)
  -- manually stop scrolling when it hits height
  if offset < 420 then
    camera:move(0, dt * 20)
  end
end

function CreditState:pressed(button)
  if button == "b" then
    song:stop()
    Gamestate.switch(StateMenu)
  end
end

function CreditState:draw()
  camera:attach()
  love.graphics.printf("Pakémon", FontHeader, 10, 0, 300, "center")
  love.graphics.printf(credits, FontBasic, 10, 30, 300, "center")
  camera:detach()
end

return CreditState