local ModulePersonality = {}

ModulePersonality.image = love.graphics.newImage("modules/personality/assets/personality.png")
local g = anim8.newGrid(32, 32, ModulePersonality.image:getWidth(), ModulePersonality.image:getHeight())

ModulePersonality.animations = {
  happy = anim8.newAnimation(g('1-6', 1), 0.5),
  excited = anim8.newAnimation(g('1-6', 2), 0.5),
  curious = anim8.newAnimation(g('1-6', 3), 0.5),
  lazy = anim8.newAnimation(g('1-6', 4), 0.5),
  sleepy = anim8.newAnimation(g('1-6', 5), 0.5),
  sad = anim8.newAnimation(g('1-6', 6), 0.5),
  runL= anim8.newAnimation(g('1-6', 7), 0.25),
  loading = anim8.newAnimation(g('1-6', 8), 0.5),
  error = anim8.newAnimation(g('1-6', 9), 0.5)
}

function ModulePersonality:load()
  pakemon.credits.text = pakemon.credits.text .. "The cat avatars came are from Terry Ritchie, modified by Clout.\n"
end

return ModulePersonality