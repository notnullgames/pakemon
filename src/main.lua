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
    if current_scene and current_scene.pressed then
        current_scene:pressed(button)
    end

    if button == 'dev' then
        DEV = not DEV
    end

    if button == 'scene' then
        set_current_scene("sceneloader")
    end

    if button == 'reload' then
        set_current_scene(scene_name)
    end

    if DEV then
        print(c('%{yellow}Pressed: %{reset}' .. button))
    end
end

function input_released(button)
    if current_scene and current_scene.released then
        current_scene:released(button)
    end

    if DEV then
        print(c('%{blue}Released:  %{reset}' .. button))
    end
end

-- set the current scene, unload the old one
function set_current_scene(name)
    if DEV then
        print('Scene: ' .. name)
        print(c('%{green}Scene:  %{reset}' .. name))
    end
    if current_scene and current_scene.unload then
        current_scene:unload(newscene)
    end
    current_scene = nil
    collectgarbage('collect')
    scene_name = name
    local code, errr = love.filesystem.load('scenes/' .. name .. '.lua')
    if err and DEV then
        print(c('%{red}%Error:  %{reset}' .. err))
    end
    current_scene = code()
    if current_scene.load then
        current_scene:load()
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
    if current_scene.update then
        current_scene:update(dt, totaltime)
    end
end

function love.draw()
    if current_scene.draw then
        current_scene:draw()
    end
    
    love.graphics.setColor( 1, 1, 1, 0.5 )
    
    if DEV then
        -- show FPS
        love.graphics.printf(love.timer.getFPS() .. " FPS", 0, 0, 320, "right")
        -- show memory usage
        love.graphics.printf(string.format("%.2fK (RAM)", collectgarbage('count')), 0, 0, 320, "left")
    end
end

