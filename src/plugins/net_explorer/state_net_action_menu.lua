local StateNetActionNmap = {}


local currentCommand = 1
local output = "output Not Set -_-"
-- nmap commands
local Commands = { 
    "quick",
    "syn",
    "ack",
    "ping",
    "tcp null"
}


-- 
-- local function output (in,out)
--     out = io.popen(in .. host )
-- end 



local function handleAction(actionName, host)

    local function runScan(command, options, target)
        command = io.popen('"' .. command  .. '" ' .. options  .. target )

        scan = command:read("*a")
        output = scan
    end

    if actionName == "quick" then
       runScan("nmap"," ", host)
    end



    if actionName == "syn" then
        runScan("nmap","-sS", host)
    end
    if actionName == "ack" then

    end
    if actionName == "ping" then

    end
    if actionName == "tcp null" then
        runScan("nmap","-sN", host)
    end
    if actionName == "ack" then

    end
end


function StateNetActionNmap:draw()
    love.graphics.setFont(FontBasic)
    love.graphics.setColor(1, 1, 1, 1)
    
    RpgLook:drawBox(0, 0, 320, 60)
    RpgLook:drawFace(macToDec(self.host.mac), 10, 5, 0.5, 0.5)
    love.graphics.print(shortenText(self.host.hostname, 36), 70, 10)
    love.graphics.print(shortenText(self.host.ipv4, 36), 70, 25)
    love.graphics.print(shortenText(self.host.mac, 36), 70, 40)

    RpgLook:drawBox(0, 60, 320, 180)
    local y = 50
    for _,v in pairs(Commands) do
        y = y + 20
        
        love.graphics.print(v, 40, y )
    end
    local p = currentCommand
    RpgLook:drawPointer(10, 70 + (20 * (currentCommand-1)))
    love.graphics.print(output, 125, 80)
    

end

function StateNetActionNmap:pressed(button)
    if button == "a" then
        print("scanning " .. self.host.ipv4 .. Commands[currentCommand] )
        handleAction(Commands[currentCommand], self.host.ipv4)

    end
    if button == "b" then
        Gamestate.switch(StateNetExplorer)
    end
    if button == "up" then
    currentCommand = currentCommand - 1
    RpgLook:soundMove()
    print(Commands[currentCommand])
end
if button == "down" then
    currentCommand = currentCommand + 1
    RpgLook:soundMove()
    print(Commands[currentCommand])
end
end

for k,v in pairs(StateNetActionNmap) do
    print(dump(k,v))
end


return StateNetActionNmap