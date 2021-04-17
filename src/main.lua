require('lib.inputmap')
require('lib.table_show')
local c = require('lib.ansicolors')

-- global to turn on developer options: press F12 to toggle
DEV = false

-- better for pixel-art
love.graphics.setDefaultFilter('nearest', 'nearest')

-- global savable player info 
PLAYER = { level = 0 }


function input_pressed(button)
    if current_gamestate and current_gamestate.pressed then
        current_gamestate:pressed(button)
    end

    if button == 'dev' then
        DEV = not DEV
    end

    if button == 'scene' then
        set_current_state("sceneloader")
    end

    if button == 'reload' then
        set_current_state(gamestate_name)
    end

    if DEV then
        print(c('%{yellow}Pressed: %{reset}' .. button))
    end
end

function input_released(button)
    if current_gamestate and current_gamestate.released then
        current_gamestate:released(button)
    end

    if DEV then
        print(c('%{blue}Released:  %{reset}' .. button))
    end
end

-- set the current gamestate, unload the old one
function set_current_state(name)
    if DEV then
        print('Scene: ' .. name)
        print(c('%{green}Scene:  %{reset}' .. name))
    end
    if current_gamestate and current_gamestate.unload then
        current_gamestate:unload(newState)
    end
    current_gamestate = nil
    collectgarbage('collect')
    gamestate_name = name
    local code, errr = love.filesystem.load('states/' .. name .. '.lua')
    if err and DEV then
        print(c('%{red}%Error:  %{reset}' .. err))
    end
    current_gamestate = code()
    if current_gamestate.load then
        current_gamestate:load()
    end
end

function save_player()
    return love.filesystem.write( "test.lua", table.show(PLAYER, "PLAYER"))
end

function load_player()
    local chunk = love.filesystem.load("savegame.lua")
    if chunk then
        chunk()
    end
    print(table.show(PLAYER, "PLAYER"))
end

function love.load()
    set_current_state("intro")
    load_player()
end

local totaltime = 0
function love.update(dt)
    totaltime = totaltime + dt
    if current_gamestate.update then
        current_gamestate:update(dt, totaltime)
    end
end

function love.draw()
    if current_gamestate.draw then
        current_gamestate:draw()
    end
    
    love.graphics.setColor( 1, 1, 1, 0.5 )
    
    if DEV then
        -- show FPS
        love.graphics.printf(love.timer.getFPS() .. " FPS", 0, 0, 320, "right")
        -- show memory usage
        love.graphics.printf(string.format("%.2fK (RAM)", collectgarbage('count')), 0, 0, 320, "left")
    end
end

