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

-- demo data - get this from nmap scan
local network = {
    { ip = "192.168.0.2", hostname = "gir.local", os="linux", type="computer" },
    { ip = "192.168.0.3", hostname = "tak.local", os="apple", type="phone" },
    { ip = "192.168.0.4", hostname = "gaz.local", os="windows", type="computer" },
    { ip = "192.168.0.5", hostname = "dib.local", os="linux", type="computer" },
    { ip = "192.168.0.6", hostname = "zim.local", os="apple", type="computer" },
    { ip = "192.168.0.7", hostname = "taz.local", os="android", type="phone" }
}
local networkName='invaders' -- get this from wifi

-- current menu choice
local selection = 1

local camera = Camera(160, 120)

function StateNetDemo:draw()
    camera:attach()
    for x,c in pairs(network) do
        local y = 40 + (x-1) * 60
        
        -- draw text
        love.graphics.printf(c.ip .. "\n" .. c.hostname, FontBasic, 130, y+10, 130, "right")
        
        -- draw device-type image
        love.graphics.draw( NetworkImages[c.type], 100, y, 0, 0.6, 0.6)
        
        -- draw OS icon
        if c.type == "computer" then
            love.graphics.draw( NetworkImages[c.os], 116, y+8, 0, 0.4, 0.4)
        else
            love.graphics.draw( NetworkImages[c.os], 119, y+18, 0, 0.4, 0.4)
        end
        
        -- draw border around current selection
        if x == selection then
            love.graphics.rectangle( "line", 80, y-10, 200, 60 )
        end
    end
    camera:detach()
    -- draw a rectangle to hide the other stuff
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", 0, 0, 320, 30 )
    love.graphics.setColor(1,1,1,1)

    love.graphics.printf(networkName, FontBasic, 10, 5, 300, "center")
end

function StateNetDemo:update(dt)
    camera:lookAt(160, 120 + ((selection -1) * 30))
end

function StateNetDemo:pressed(button)
    if button == "up" then
        selection = selection - 1
        if selection < 1 then
            selection = #network
        end
        SoundMove:stop()
        SoundMove:play()
    end
    if button == "down" then
        selection = selection + 1
        if selection > #network then
            selection = 1
        end
        SoundMove:stop()
        SoundMove:play()
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