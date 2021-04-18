require('lib.inputmap')
require('lib.table_show')
local c = require('lib.ansicolors')

-- global to turn on developer options: press F12 to toggle
DEV = false

-- better for pixel-art
love.graphics.setDefaultFilter('nearest', 'nearest')

-- global savable player info 
PLAYER = { level = 0, scene = "welcome" }


function input_pressed(button)
    if current_gamescene and current_gamescene.pressed then
        current_gamescene:pressed(button)
    end

    if button == 'dev' then
        DEV = not DEV
    end

    if button == 'scene' then
        set_current_scene("sceneloader")
    end

    if button == 'reload' then
        set_current_scene(gamescene_name)
    end

    if DEV then
        print(c('%{yellow}Pressed: %{reset}' .. button))
    end
end

function input_released(button)
    if current_gamescene and current_gamescene.released then
        current_gamescene:released(button)
    end

    if DEV then
        print(c('%{blue}Released:  %{reset}' .. button))
    end
end

-- set the current gamescene, unload the old one
function set_current_scene(name)
    if DEV then
        print('Scene: ' .. name)
        print(c('%{green}Scene:  %{reset}' .. name))
    end
    if current_gamescene and current_gamescene.unload then
        current_gamescene:unload(newscene)
    end
    current_gamescene = nil
    collectgarbage('collect')
    gamescene_name = name
    local code, errr = love.filesystem.load('scenes/' .. name .. '.lua')
    if err and DEV then
        print(c('%{red}%Error:  %{reset}' .. err))
    end
    current_gamescene = code()
    if current_gamescene.load then
        current_gamescene:load()
    end
end

function save_player()
    return love.filesystem.write( "savegame.lua", table.show(PLAYER, "PLAYER"))
end

function load_player()
    local chunk = love.filesystem.load("savegame.lua")
    if chunk then
        chunk()
    end
    print(table.show(PLAYER, "PLAYER"))
end

function love.load()
    set_current_scene("intro")
end

local totaltime = 0
function love.update(dt)
    totaltime = totaltime + dt
    if current_gamescene.update then
        current_gamescene:update(dt, totaltime)
    end
end

function love.draw()
    if current_gamescene.draw then
        current_gamescene:draw()
    end
    
    love.graphics.setColor( 1, 1, 1, 0.5 )
    
    if DEV then
        -- show FPS
        love.graphics.printf(love.timer.getFPS() .. " FPS", 0, 0, 320, "right")
        -- show memory usage
        love.graphics.printf(string.format("%.2fK (RAM)", collectgarbage('count')), 0, 0, 320, "left")
    end
end

