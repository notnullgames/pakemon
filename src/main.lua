-- global libs
Camera = require "lib.hump.camera"
Class = require "lib.hump.class"
Gamestate = require "lib.hump.gamestate"
Timer = require "lib.hump.timer"
anim8 = require "lib.anim8.anim8"
lurker = require "lib.lurker.lurker"
lovebird = require "lib.lovebird.lovebird"
require "lib.inputmap"
require "lib.shared"

-- all hosts are allowed
lovebird.whitelist = nil

-- call current GameState's enter() on hot-reload
lurker.postswap = function()
  local gs = Gamestate.current()
  if gs and gs.enter then
    gs:enter()
  end
end

-- global namespace
pakemon = {}

function love.load()
  love.mouse.setVisible(false)
  -- I register without draw or update, or inputs, so I can control those
  Gamestate.registerEvents({ "init", "enter", "leave", "resume", "focus", "quit" })

  -- load all modules
  local files = love.filesystem.getDirectoryItems("modules")
  for _,p in pairs(files) do
    if string.sub(p, 1, 1) ~= '.' then
      pakemon[p] = require("modules."..p..".init")
    end
  end

  -- loop through them again to call load
  for _,p in pairs(files) do
    if string.sub(p, 1, 1) ~= '.' then
      if pakemon[p].load then
        pakemon[p]:load()
      else
        print("No load(): " .. p)
      end
    end
  end
end

function love.update(dt)
  lovebird.update()
  Gamestate.update(dt)
  Timer.update(dt)
  -- if a module has update() call it, for off-screen updates
  for _,mod in pairs(pakemon) do
    if mod.update then
    	mod:update(dt)
    end
  end
end

function love.draw()
  Gamestate.draw()
  -- if a module has draw() call it
  for _,mod in pairs(pakemon) do
    if mod.draw then
      mod:draw(dt)
    end
  end
end

-- use more general input-manager instead of key/gamepad
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