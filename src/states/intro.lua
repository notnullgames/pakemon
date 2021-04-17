local flux = require('lib.flux')
local cat = require('lib.cat')

local StateIntro = {}

local speed = 60
local step = 1

local title = love.graphics.newImage("assets/title.png")
local far_buildings = love.graphics.newImage("assets/far-buildings.png")
local back_buildings = love.graphics.newImage("assets/back-buildings.png")
local foreground = love.graphics.newImage("assets/foreground.png")
local song = love.audio.newSource("assets/the_golden_ages.mod", "static")
local sound_move = love.audio.newSource("assets/move.wav", "static")

-- these are animated using tweens, then used to draw things
local title_info = { x = 80, y = 0 }
local start_info = { a = 0 }
local far_buildings_info = { w = 320, y = 0 }
local back_buildings_info = { w = 320, y = -20 }
local foreground_info = { w = 352, y = 50 }

local blink_tween
local parallax_tween

-- called in loop to blink text
function do_blink()
  blink_tween=flux.to(start_info, 1, { a = 0.5 })
    :ease("sineout")
    :after(start_info, 1, { a = 1 })
    :ease("sinein")
    :oncomplete(do_blink)
end

-- called in a loop to move a parallax layer
function move_layer(time, data)
  data.x = data.w
  parallax_tween=flux.to(data, time, { x = 0 })
    :ease("linear")
    :oncomplete(function()
      data.x = data.w
      move_layer(time, data)
    end)
end

-- called when this loads
function StateIntro:load()
  song:play()
  
  -- setup drop-animation for logo
  flux.to(title_info, 14, { y = 60 }):oncomplete(function()
    sound_move:play()
  end)

  -- setup fading blink for text
  flux.to(start_info, 1, { a = 1 })
    :ease("sinein")
    :delay(14)
    :oncomplete(do_blink)

  -- setup rotating parallax layers
  move_layer(60, far_buildings_info)
  move_layer(30, back_buildings_info)
  move_layer(10, foreground_info)
end

-- called when some othe rstate is chosen
function StateIntro:unload()
  song:stop()
  if blink_tween then
    blink_tween:stop()
  end
  parallax_tween:stop()
end

-- called to update logic
function StateIntro:update(dt, totaltime)
  flux.update(dt)
  cat.runL:update(dt)
end

-- callled in main draw loop
function StateIntro:draw()
  love.graphics.setColor(1, 1, 1, 1)

  love.graphics.draw(far_buildings, far_buildings_info.x, far_buildings_info.y)
  love.graphics.draw(far_buildings, far_buildings_info.x-far_buildings_info.w, far_buildings_info.y)

  love.graphics.draw(back_buildings, back_buildings_info.x, back_buildings_info.y)
  love.graphics.draw(back_buildings, back_buildings_info.x-back_buildings_info.w, back_buildings_info.y)

  love.graphics.draw(foreground, foreground_info.x, foreground_info.y)
  love.graphics.draw(foreground, foreground_info.x-foreground_info.w, foreground_info.y)

  cat.runL:draw(cat.image, 150, 200)
  
  love.graphics.draw(title, title_info.x, title_info.y)
  
  love.graphics.setColor(1, 1, 1, start_info.a)
  love.graphics.printf("PRESS BUTTON", 0, 130, 320, "center")
end

function StateIntro:pressed(button)
  if button == "a" or button == "b" or button == "start" then
    set_current_state("menu")
  end
end


return StateIntro
