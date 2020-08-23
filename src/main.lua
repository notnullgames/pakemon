-- these are global libraries you can use in your own states
anim8 = require "lib.anim8"
Camera = require "lib.hump.camera"
Class = require "lib.hump.class"
fs = require "lib.fs"
Gamestate = require "lib.hump.gamestate"
globtopattern = require "lib.globtopattern"
lurker = require "lib.lurker.lurker"
require "lib.inputmap"
Timer = require "lib.hump.timer"
require "lib.utils"
RpgLook = require "lib.rpg_look"

love.graphics.setDefaultFilter("nearest", "nearest")

-- some basic fonts for everyone to use
FontDefault = love.graphics.newFont()
FontBasic = love.graphics.newFont("assets/monoid.ttf", 10)
FontHeader = love.graphics.newFont("assets/heavydata.ttf", 15)

-- staret of credits
local creditsApp = [[
  was made possible by the labor of love of many people.
  
  Konsumer & Clout made a lot of the code & graphics.
  
  Love2D provides the input/sound/graphics engine.
  
  The cool song you are hearing right now is by Strobe. It's called "Android Assembled". Go check out their other awesome work on the mod-archive.
  
]]

-- autoload built-in plugins
plugins = {}
files = love.filesystem.getDirectoryItems("plugins")
for _,p in pairs(files) do
  print("plugins."..p..".plugin found")
  if string.sub(p, 1, 1) ~= '.' then
    plugins[p] = require("plugins."..p..".plugin")
  end
end

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
  -- I register without draw or update, or inputs, so I can control those
  Gamestate.registerEvents({ "init", "enter", "leave", "resume", "focus", "quit" })
  -- add credit preamble
  plugins.credits.credits = creditsApp
  
  -- demos sub-menu on menu #2
  plugins.menu.main:addMenu({})

  -- load initial states for things
  for i,plugin in pairs(plugins) do
    if plugin.load then
      plugin:load()
    end
  end

  -- add top-level menus
  plugins.menu.main:addItem("Demos", function() plugins.menu.main:setCurrentMenu(2) end)
  plugins.menu.main:addItem("Quit", function() love.event.quit() end)
end

function love.update(dt)  
  -- hot-reloading
  Gamestate.update(dt)
  lurker.update()
  Timer.update(dt)
  -- if a plugin has update() call it, for off-screen updates
  for i,plugin in pairs(plugins) do
    if plugin.update then
      plugin:update(dt)
    end
  end
end

function love.draw()
  Gamestate.draw()
  -- if a plugin has draw() call it
  for i,plugin in pairs(plugins) do
    if plugin.draw then
      plugin:draw(dt)
    end
  end
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
