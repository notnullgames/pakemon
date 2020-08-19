local StateNetDemo = {}

-- global images other people can use
NetworkImages = {
    apple = love.graphics.newImage("plugins/net_demo/apple.png"),
    windows = love.graphics.newImage("plugins/net_demo/windows.png"),
    android = love.graphics.newImage("plugins/net_demo/android.png"),
    linux = love.graphics.newImage("plugins/net_demo/linux.png"),
    computer = love.graphics.newImage("plugins/net_demo/computer.png"),
    phone = love.graphics.newImage("plugins/net_demo/phone.png")
}

local network = httpGetJson("http://127.0.0.1:8081/api/session/lan")

local function net_table()
    for index,host in pairs(network) do 
        print("index: " .. index)
        for c,t in pairs(host) do
            print(c,t)
            for key,value in pairs(t) do
                -- for key,table in pairs(k) do
                --     print(key,table)
                -- end
                print(key,value)     
                print("######################################")           
            end 
        end 
    end
end


function StateNetDemo:draw()

 
    --    love.graphics.print(#network, 20, 20, 0, 4, 4)
    -- for _,v in ipairs(network) do
    --     love.graphics.print(v)
    -- end
end




-- current menu choice
--local selection = 1

-- local camera = Camera(160, 120)
-- function StateNetDemo:draw()
--     camera:attach()
--     for x,c in pairs(network) do

--         local y = 40 + (x-1) * 60
        
--         -- draw text
--         love.graphics.printf(c.ip .. "\n" .. c.hostname, FontBasic, 130, y+10, 130, "right")
        
--         -- draw device-type image
--         love.graphics.draw( NetworkImages[c.type], 100, y, 0, 0.6, 0.6)
        
--         -- draw OS icon
--         if c.type == "computer" then
--             love.graphics.draw( NetworkImages[c.os], 116, y+8, 0, 0.4, 0.4)
--         else
--             love.graphics.draw( NetworkImages[c.os], 119, y+18, 0, 0.4, 0.4)
--         end
        
--         -- draw border around current selection
--         if x == selection then
--             love.graphics.rectangle( "line", 80, y-10, 200, 60 )
--         end
--     end
--     camera:detach()
--     -- draw a rectangle to hide the other stuff
--     love.graphics.setColor(0,0,0,1)
--     love.graphics.rectangle( "fill", 0, 0, 320, 30 )
--     love.graphics.setColor(1,1,1,1)

--     love.graphics.printf(networkName, FontHeader, 10, 5, 300, "center")
-- end

-- function StateNetDemo:update(dt)
--     camera:lookAt(160, 120 + ((selection -1) * 60))
-- end

function StateNetDemo:pressed(button)
    -- if button == "up" then
    --     selection = selection - 1
    --     if selection < 1 then
    --         selection = #network
    --     end
    --     SoundMove:stop()
    --     SoundMove:play()
    -- end
    -- if button == "down" then
    --     selection = selection + 1
    --     if selection > #network then
    --         selection = 1
    --     end
    --     SoundMove:stop()
    --     SoundMove:play()
    -- end

    if button == "y" then
        net_table()
    end
    if button == "b" then
        SoundBack:play()
        Gamestate.switch(self.oldGs or StateMainMenu)
    end
    if button == "a" then
        SoundOk:play()
        print("do your stuff here")
    end
end

return StateNetDemo