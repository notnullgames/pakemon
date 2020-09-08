-- register global menu sounds for other plugins to use
SoundBack = love.audio.newSource("modules/menu/assets/back.wav", "static")
SoundMove = love.audio.newSource("modules/menu/assets/move.wav", "static")
SoundOk = love.audio.newSource("modules/menu/assets/ok.wav", "static")

-- register global gamestates
StateMainMenu = require "modules.menu.state_main_menu"

local function showDemos()
  table.insert(pakemon.menu.oldMenu, (pakemon.menu.currentMenu or 0))
  pakemon.menu.currentMenu = 2
end

local ModuleMenu = { menuItems = {{ {"Demos", showDemos}  }, {}}, currentMenu = 1, currentItem = 1, oldMenu = {} }

function ModuleMenu:load()
end

return ModuleMenu