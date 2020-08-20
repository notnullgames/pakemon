local StateNetExplorer = {}
local selection = 1
local updateTime = 0
local camera = Camera(160, 120)

local network
local currentNet = null

-- global images other people can use
NetworkImages = {
    apple = love.graphics.newImage("plugins/net_explorer/apple.png"),
    windows = love.graphics.newImage("plugins/net_explorer/windows.png"),
    android = love.graphics.newImage("plugins/net_explorer/android.png"),
    linux = love.graphics.newImage("plugins/net_explorer/linux.png"),
    computer = love.graphics.newImage("plugins/net_explorer/computer.png"),
    phone = love.graphics.newImage("plugins/net_explorer/phone.png")
}

function StateNetExplorer:update(dt)
    if updateTime == 0 or updateTime > 15 then
        updateTime = 0.1
        network = httpGetJson("http://127.0.0.1:8081/api/session/lan")

        if network then
            local many = "s"
            if network.hosts then
                if #network.hosts == 1 then
                    many = ""
                end
                local menu = {}
                for i,v in pairs(network.hosts) do
                    table.insert(menu, {v.ipv4, function() print(v.ipv4) end })
                end
            end
        end
    end
    updateTime = updateTime + dt
    camera:lookAt(160, 120 + ((selection -1) * 40))
end
 
function StateNetExplorer:draw()
    love.graphics.setBackgroundColor(0.039, 0, 0.39, 1)
    if network and network.hosts then
        camera:attach()
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(FontBasic)
        for i,host in pairs(network.hosts) do
            local y = 40 + (i-1) * 60     
            -- draw text
            love.graphics.print("IP: " ..  host.ipv4 .. "\n" .. 
                                "MAC: " .. host.mac .. "\n" .. 
                                "Name: " .. shortenText(host.hostname,23), 10, y-10 ) 
            if i == selection then
                love.graphics.rectangle( "line", 10, y-10, 200, 45 )
            end
        end
        camera:detach()
        
        love.graphics.setColor(0.039, 0, 0.39,1)
        love.graphics.rectangle( "fill", 0, 0, 320, 30 )
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(FontHeader)
        love.graphics.print(#network.hosts .. "! hosts"  .. " found", 10, 10)
    else
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(FontHeader)
        love.graphics.print("Searching for hosts...", 10, 10) 
    end
end

function StateNetExplorer:pressed(button)
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
    if button == "b" then
        SoundBack:play()
        io.popen(stopBettercap)
        Gamestate.switch(self.oldGs or StateMainMenu)
    end
    if button == "a" then
        SoundOk:play()
        print(currentNet)
    end
end

return StateNetExplorer