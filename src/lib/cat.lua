local anim8 = require('lib.anim8')

local cat = {
  image = love.graphics.newImage("assets/cat.png")
}

local g = anim8.newGrid(32, 32, cat.image:getWidth(), cat.image:getHeight())

cat.happy = anim8.newAnimation(g('1-6', 1), 0.5)
cat.excited = anim8.newAnimation(g('1-6', 2), 0.5)
cat.curious = anim8.newAnimation(g('1-6', 3), 0.5)
cat.lazy = anim8.newAnimation(g('1-6', 4), 0.5)
cat.sleepy = anim8.newAnimation(g('1-6', 5), 0.5)
cat.sad = anim8.newAnimation(g('1-6', 6), 0.5)
cat.runL= anim8.newAnimation(g('1-6', 7), 0.25)
cat.loading = anim8.newAnimation(g('1-6', 8), 0.5)
cat.error = anim8.newAnimation(g('1-6', 9), 0.5)

return cat