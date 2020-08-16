local StateCityDemo = {}

local speed = 4
local direction = -1 

local far_buildings = love.graphics.newImage("plugins/city_demo/far-buildings.png")
local back_buildings = love.graphics.newImage("plugins/city_demo/back-buildings.png")
local foreground = love.graphics.newImage("plugins/city_demo/foreground.png")
local song = love.audio.newSource("plugins/credits/assets/strobe_-_android_assembled.xm", "stream")
song:setLooping(true)

function StateCityDemo:enter()
  song:play()
end

local timefar = 0
local timeback = 0
local timefore = 0

function StateCityDemo:update(dt)
  timefar = timefar + (dt * speed)
  timeback = timeback + (dt * speed * 3)
  timefore = timefore + (dt * speed * 8)
end

function StateCityDemo:draw()
  local tf = timefar % 320
  local tb = timeback % 320
  local tfo = timefore % 320
  
  love.graphics.draw( far_buildings, tf * direction, 0, 0, 1.5, 1.5 )
  love.graphics.draw( far_buildings, (tf - 320) * direction, 0, 0, 1.5, 1.5 )

  love.graphics.draw( back_buildings, tb * direction, 20)
  love.graphics.draw( back_buildings, (tb - 320) * direction, 20)

  love.graphics.draw( foreground, tfo * direction, 50)
  love.graphics.draw( foreground, (tfo - 320) * direction, 50)

  love.graphics.push()
  love.graphics.scale(4, 4)
  plugins.personality.mood = "curious"
  plugins.personality:drawMe(23.5,5)
  love.graphics.print("Pakémon", 10, 34)
  love.graphics.pop()
end

function StateCityDemo:pressed(button)
  if button == "b" then
    song:stop()
    Gamestate.switch(StateMainMenu)
  end
end

return StateCityDemo