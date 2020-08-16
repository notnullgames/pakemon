local StateCity = {}

local speed = 4
local direction = -1 

local title = love.graphics.newImage("plugins/intro/title.png")
local far_buildings = love.graphics.newImage("plugins/intro/far-buildings.png")
local back_buildings = love.graphics.newImage("plugins/intro/back-buildings.png")
local foreground = love.graphics.newImage("plugins/intro/foreground.png")
local song = love.audio.newSource("plugins/credits/assets/strobe_-_android_assembled.xm", "stream")

song:setLooping(true)

function StateCity:enter()
 -- song:play()
end

local timefar = 0
local timeback = 0
local timefore = 0
local down = -34

local soundplayed = false

function StateCity:update(dt)
  timefar = timefar + (dt * speed)
  timeback = timeback + (dt * speed * 3)
  timefore = timefore + (dt * speed * 8)
  
  if down < 60 then
    down = down + (dt * speed * 20 )
  elseif not soundplayed then
    SoundMove:play()
    soundplayed = true
  end
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

  love.graphics.push()
  love.graphics.scale( 1, 1 )
  plugins.personality.mood = "runL"
  plugins.personality:drawMe( 150, 200, 0, .25, .25 )
  love.graphics.draw(title, 100, down, 0, .05, .05 )
  love.graphics.pop()
  
  if down >= 60 then 
    love.graphics.print("start", 150, 150) 
  end

end

function StateCity:pressed(button)
  if button == "start" then
    song:stop()
    SoundOk:play()
    Gamestate.switch(StateMainMenu)
  end
end

return StateCity