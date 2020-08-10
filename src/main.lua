-- these are global libraries you can use in your own states
globtopattern = require "lib.globtopattern"
json = require "lib.json"
lurker = require "lib.lurker.lurker"
Gamestate = require "lib.hump.gamestate"
Camera = require "lib.hump.camera"
Class = require "lib.hump.class"

require "inputmap"
fs = require "fs"
MenuManager = require "menu_manager"

-- this is a global font for regular stuff
FontBasic = love.graphics.newFont("assets/monoid.ttf", 10)

-- normally this will be auto-loaded at start from plugins in dir + zip files
-- I am doing it manually, here, so you can see how it works, in a basic way
StateMenu = require "plugins.mainmenu.plugin"

function love.load()
  love.graphics.setFont(FontBasic)
  love.keyboard.setKeyRepeat(true)
  love.mouse.setVisible(false)
  Gamestate.registerEvents()
  Gamestate.switch(StateMenu)
end

function love.update(dt)  
  -- hot-reloading
  lurker.update()
end

function input_pressed(button)
  local gs = Gamestate.current()
  if gs.pressed then
    gs:pressed(button)
  end
end

function input_released(button)
  local gs = Gamestate.current()
  if gs.released then
    gs:released(button)
  end
end

