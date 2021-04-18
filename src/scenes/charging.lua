-- fake charging screen

local SceneCharging = {}

local scale = 10
local sheet = love.graphics.newImage("assets/battery.png")
local heart = love.graphics.newQuad(0, 0, 7, 7, sheet)
local battery = love.graphics.newQuad(7, 0, 13, 7, sheet)
local bar_red = love.graphics.newQuad(0, 7, 2, 4, sheet)
local bar_grey = love.graphics.newQuad(2, 7, 2, 4, sheet)

local do_red = false

-- called when some othe rscene is chosen
function SceneCharging:unload()
end

-- called to update logic
function SceneCharging:update(dt, totaltime)
  do_red = math.floor(totaltime) % 2 == 0
end

-- called when a button is pressed
function SceneCharging:pressed(button)
end

-- called when a button is released
function SceneCharging:released(button)
end

-- callled in main draw loop
function SceneCharging:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )
  
  love.graphics.draw(sheet, heart, 50, 85, 0, scale, scale)
  love.graphics.draw(sheet, battery, 130, 85, 0, scale, scale)

  if do_red then
    love.graphics.draw(sheet, bar_red, 150, 100, 0, scale, scale)
  else
    love.graphics.draw(sheet, bar_grey, 150, 100, 0, scale, scale)
  end
  love.graphics.draw(sheet, bar_grey, 180, 100, 0, scale, scale)
  love.graphics.draw(sheet, bar_grey, 210, 100, 0, scale, scale)
end

return SceneCharging
