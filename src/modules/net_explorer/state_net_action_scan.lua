local StateNetActionScan = {}

-- this will hold the log of the output
local output = ""

local function getPortsForMac(mac)
    output = ""
    local net = pakemon.bettercap:lan()
    if net and net.hosts then
        for i,host in pairs(net.hosts) do
            if host.mac and host.mac == mac and host.meta and host.meta.values and host.meta.values.ports then
                for p,port in pairs(host.meta.values.ports) do
                    output = output .. p .. " - "
                    if port then
                        output = output .. ((shortenText(port.banner, 35)..": "..port.service) or (port.service .. "?") or "????") .. "\n"
                    else
                        output = output .. p .. ": ????\n"
                    end
                end
            end
        end
    end
end

-- periodically update ports-list

local timerhandle

function StateNetActionScan:enter()
    pakemon.bettercap:run("syn.scan "..self.host.ipv4)
    timerhandle = Timer.every(2, function() data = getPortsForMac(self.host.mac)  end)
    getPortsForMac(self.host.mac)
end

function StateNetActionScan:leave()
    pakemon.bettercap:run("syn.scan off")
    Timer.cancel(timerhandle)
end

function StateNetActionScan:draw()
    pakemon.rpg_look:drawBox(0, 0, 320, 60)
    
    love.graphics.setFont(FontDefault)
    love.graphics.setColor(1, 1, 1, 1)
    
    pakemon.rpg_look:drawFace(macToDec(self.host.mac), 10, 5, 0.5, 0.5)
    love.graphics.print(shortenText(self.host.hostname, 36), 70, 10)
    love.graphics.print(shortenText(self.host.ipv4, 36), 70, 25)
    love.graphics.print(shortenText(self.host.mac, 36), 70, 40)

    pakemon.rpg_look:drawBox(0, 60, 320, 180)

    love.graphics.setColor(1, 1, 1, 1)

    if output and output ~= "" then
        love.graphics.printf(output,5, 65, 310)
    else
        love.graphics.printf("Looking for ports...",5, 65, 310)
    end
end

function StateNetActionScan:pressed(button)
    if button == "b" then
        Gamestate.switch(StateNetExplorer)
    end
end

return StateNetActionScan
