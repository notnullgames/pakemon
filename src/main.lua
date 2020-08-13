-- these are global libraries you can use in your own states
globtopattern = require "lib.globtopattern"
anim8 = require "lib.anim8"
json = require "lib.json"
lurker = require "lib.lurker.lurker"
Gamestate = require "lib.hump.gamestate"
Camera = require "lib.hump.camera"
Class = require "lib.hump.class"
Timer = require "lib.hump.timer"
require "inputmap"
fs = require "fs"
MenuManager = require "menu_manager"

-- some basic assets for everyone to use
FontBasic = love.graphics.newFont("assets/monoid.ttf", 10)
FontHeader = love.graphics.newFont("assets/heavydata.ttf", 15)

SoundBack = love.audio.newSource("assets/back.wav", "static")
SoundMove = love.audio.newSource("assets/move.wav", "static")
SoundOk = love.audio.newSource("assets/ok.wav", "static")

-- normally this will be auto-loaded at start from plugins in dir + zip files
-- I am doing it manually, here, so you can see how it works, in a basic way
-- and because we don't really need a full plugin system, yet
-- I will need to check if exported interface is a GameState
StateMenu = require "plugins.mainmenu.plugin"
StateAirplanes = require "plugins.airplanes.plugin"
personality = require "plugins.personality.plugin"

-- call current GameState's enter() on hot-reload
lurker.postswap = function()
  local gs = Gamestate.current()
  if gs and gs.enter then
    gs:enter()
  end
end

function love.load()
  love.graphics.setFont(FontBasic)
  love.mouse.setVisible(false)
  Gamestate.registerEvents()
  -- Gamestate.switch(StateMenu)
  Gamestate.switch(StateAirplanes)
end

function love.update(dt)  
  -- hot-reloading
  lurker.update()
  Timer.update(dt)
  local gs = Gamestate.current()
  personality:update(dt)
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
