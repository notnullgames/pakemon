local StateNetExplorer = {}
local selection = 1
local updateTime = 0
local camera = Camera(160, 120)

local network = {}
local menuNet
local cuurentNet = null
local sideMenu = {  "nmap", "info", "Deep Exploit" }

-- global images other people can use
NetworkImages = {
    apple = love.graphics.newImage("plugins/net_explorer/apple.png"),
    windows = love.graphics.newImage("plugins/net_explorer/windows.png"),
    android = love.graphics.newImage("plugins/net_explorer/android.png"),
    linux = love.graphics.newImage("plugins/net_explorer/linux.png"),
    computer = love.graphics.newImage("plugins/net_explorer/computer.png"),
    phone = love.graphics.newImage("plugins/net_explorer/phone.png")
}


--table.insert(sideMenu, "info", "nmap", "Deep Exploit")
local p
-- leaving global for now, unless we find issues with it running all the time.
-- might be nice to have this exposed on the global scope. 
bettercap_dockerName="pakemon-bettercap"
local dockerName = bettercap_dockerName

runBettercap="docker run --rm -it --privileged --name " .. dockerName .. ' --net=host bettercap/bettercap -eval "netmon; api.rest on"'
stopBettercap="docker kill --signal=SIGHUP " .. dockerName

local function handleExit()
    io.popen(stopBettercap)
    p:close()
end

function StateNetExplorer:enter()
    menuNet = MenuManager()
    io.popen(runBettercap)
end

function StateNetExplorer:update(dt)
    if updateTime == 0 or updateTime > 15 then
        updateTime = 0.1
        local lan = httpGetJson("http://127.0.0.1:8081/api/session/lan")
        if lan then
            network = lan
        end  
        local many = "s"
        if #network.hosts == 1 then
            many = ""
        end
        menuNet:setTitle(#network.hosts .. "! hosts"  .. many .. " found")
        local menu = {}
        for i,v in pairs(network.hosts) do
            table.insert(menu, {v.ipv4, function() print(v.ipv4) end })
 --           print(v.ipv4) -- this prints ip range.
        end
        menuNet:setMenus({ menu })
    end
    updateTime = updateTime + dt
    menuNet:update(dt)
    camera:lookAt(160, 120 + ((selection -1) * 40))
end
 
function StateNetExplorer:draw()
    -- for k,v in pairs(sideMenu) do
    --     print(v)
    -- end
    camera:attach()
    
    for i,host in pairs(network.hosts) do
        local y = 40 + (i-1) * 60     
        
        -- draw text
        love.graphics.setFont(FontBasic)
        love.graphics.print("IP: " ..  host.ipv4 .. "\n" .. 
                            "MAC: " .. host.mac .. "\n" .. 
                            "Name: " .. shortenText(host.hostname,23), 10, y-10 ) 
        
        if i == selection then
            love.graphics.rectangle( "line", 10, y-10, 200, 45 )
        end
    end
    camera:detach()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", 0, 0, 320, 30 )
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(FontHeader)
    -- love.graphics.print(#network.hosts .. "! host" .. many  .. " found", 10, 10)
    love.graphics.print(#network.hosts .. "! hosts"  .. " found", 10, 10) 
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
        -- Gamestate.switch(StateYOURSTATEHERE)

    end
end

return StateNetExplorer