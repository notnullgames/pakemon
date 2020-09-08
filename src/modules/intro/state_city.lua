local StateCity = {}

local speed = 4
local direction = -1 

local title = love.graphics.newImage("modules/intro/assets/title.png")
local far_buildings = love.graphics.newImage("modules/intro/assets/far-buildings.png")
local back_buildings = love.graphics.newImage("modules/intro/assets/back-buildings.png")
local foreground = love.graphics.newImage("modules/intro/assets/foreground.png")
local song = love.audio.newSource("modules/intro/assets/the_golden_ages.mod", "stream")

song:setLooping(true)

local timefar
local timeback
local timefore
local down
local soundplayed

function StateCity:enter()
  timefar = 0
  timeback = 0
  timefore = 0
  down = -34
  soundplayed = false
  song:play()
end

function StateCity:update(dt)
  timefar = timefar + (dt * speed)
  timeback = timeback + (dt * speed * 3)
  timefore = timefore + (dt * speed * 8)
  
  if down < 60 then
    down = down + (dt * speed * 1.6 )
  elseif not soundplayed then
    SoundMove:play()
    soundplayed = true
  end

  pakemon.personality.animations.runL:update(dt)
end

function StateCity:draw()
  local tf = timefar % 320
  local tb = timeback % 320
  local tfo = timefore % 320
  
  love.graphics.draw( far_buildings, tf * direction, 0, 0, 1.5, 1.5 )
  love.graphics.draw( far_buildings, (tf - 320) * direction, 0, 0, 1.5, 1.5 )

  love.graphics.draw( back_buildings, tb * direction, 20)
  love.graphics.draw( back_buildings, (tb - 320) * direction, 20)

  love.graphics.draw( foreground, tfo * direction, 50)
  love.graphics.draw( foreground, (tfo - 320) * direction, 50)

  love.graphics.draw(title, 80, down, 0, .06, .06 )

  pakemon.personality.animations.runL:draw(pakemon.personality.image, 150, 200)

  if down >= 60 then 
    love.graphics.print("start", 150, 150) 
  end
end

function StateCity:pressed(button)
  if button == "start" or button == "a" or button == "b" then
    song:stop()
    SoundOk:play()
    Gamestate.switch(StateMainMenu)
  end
end

return StateCity