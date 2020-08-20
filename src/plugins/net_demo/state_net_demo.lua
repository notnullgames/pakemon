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


local selection = 1
local camera = Camera(160, 120)
function StateNetDemo:draw()
    love.graphics.print("I found this many hosts! " .. #network.hosts, 10, 10)
    camera:attach()
    
    for i,host in pairs(network.hosts) do
        local y = 40 + (i-1) * 40     
        
        -- draw text
        love.graphics.print(host.ipv4 .. "\n" .. host.mac, 10, y-10 ) --60 * i)
        
        if i == selection then
            love.graphics.rectangle( "line", 10, y-10, 200, 35 )
        end
    end
    camera:detach()
 end


function StateNetDemo:update(dt)
   camera:lookAt(160, 120 + ((selection -1) * 40))
end

function StateNetDemo:pressed(button)
    if button == "up" then
        selection = selection - 1
        if selection < 1 then
            selection = #network.hosts
        end
        SoundMove:stop()
        SoundMove:play()
    end
    if button == "down" then
        selection = selection + 1
        if selection > #network.hosts then
            selection = 1
        end
        SoundMove:stop()
        SoundMove:play()
    end

    -- if button == "y" then
    --     net_table()
    -- end
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