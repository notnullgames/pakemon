local StateNetExplorer = {}

local actions = {
    "Ports",
    "Exploit"
}

-- things that track current state
local hosts = {}
local menuMode = "person"
local currentPerson = 1
local currentAction = 1
local timerhandle

-- put your handler here. You have access to the host and the action
local function handleAction(actionName, host)
    local stateNext

    if actionName == "Ports" then
        stateNext =  StateNetActionScan
    end

    if actionName == "Exploit" then
        stateNext =  StateNetActionExploit
    end

    if stateNext ~= nil then
        -- tell the next state about host-choice, and change to it
        stateNext.host = host
        Gamestate.switch(stateNext)
    else
        plugins.personality:notify("Action not implemented: " .. actionName)
    end
end

-- draw 1 person
local function drawOnePerson(y, index, hostname, ip, mac)
    pakemon.rpg_look:drawFace(macToDec(mac), 20, 10 + (y-1) * 58, 0.5, 0.5)
    love.graphics.setFont(FontDefault)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(shortenText(hostname, 22), 80, 10 + (y-1) * 58)
    love.graphics.print(shortenText(ip, 22), 80, 28 + (y-1) * 58)
    love.graphics.print(shortenText(mac, 22), 80, 44 + (y-1) * 58)
end

-- draw the actions menu
local function drawActions()
    love.graphics.setColor(1, 1, 1, 1)
    for i, action in pairs(actions) do
        love.graphics.print(action, 260, 25 + (i-1) * 20)
    end
end

-- get list of hosts on network
local function updateHosts()
    local net = httpGetJson("http://127.0.0.1:8081/api/session/lan")
    if net and net.hosts then
        hosts = net.hosts
        -- sort by mac-address, for a semi-reliable order
        table.sort(hosts, function(a, b) return macToDec(a.mac) > macToDec(b.mac) end)
    end
end

function StateNetExplorer:enter()
    pakemon.bettercap:run('net.probe on')
    timerhandle = Timer.every(3, updateHosts)
    updateHosts()
end

function StateNetExplorer:leave()
    Timer.cancel(timerhandle)
    pakemon.bettercap:run('net.probe off')
end

function StateNetExplorer:pressed(button)
    if menuMode == "person" then
        if button == "b" then
            Gamestate.switch(StateMainMenu)
        end
        if button == "a" and #hosts > 0 then
            menuMode = "action"
            pakemon.rpg_look:soundSelect()
        end
        if button == "up" and #hosts > 0 then
            currentPerson = currentPerson - 1
            pakemon.rpg_look:soundMove()
        end
        if button == "down" and #hosts > 0 then
            currentPerson = currentPerson + 1
            pakemon.rpg_look:soundMove()
        end
    else
        if button == "b" then
            pakemon.rpg_look:soundSelect()
            menuMode = "person"
        end
        if button == "a" then
            pakemon.rpg_look:soundAction()
            handleAction(actions[currentAction], hosts[currentPerson])
        end
        if button == "up" then
            currentAction = currentAction - 1
            pakemon.rpg_look:soundMove()
        end
        if button == "down" then
            currentAction = currentAction + 1
            pakemon.rpg_look:soundMove()
        end
    end
    if currentPerson > #hosts then
        currentPerson = 1
    end
    if currentPerson < 1 then
        currentPerson = #hosts
    end
    if currentAction > #actions then
        currentAction = 1
    end
    if currentAction < 1 then
        currentAction = #actions
    end
end

function StateNetExplorer:draw()
    pakemon.rpg_look:drawBox(0, 0, 240, 240)
    pakemon.rpg_look:drawBox(240, 0, 80, 240)

    local p = math.floor((currentPerson-1) / 4)
    local o = p * 4

    love.graphics.setFont(FontDefault)
    love.graphics.setColor(1, 1, 1, 1)

    if #hosts > 0 then
        for i = 1,4 do
            local t = i + o
            local host = hosts[t]
            if host then
                drawOnePerson(i, t, host.hostname, host.ipv4, host.mac )
            end
        end
        drawActions()

        -- draw person icon either way
        pakemon.rpg_look:drawPointer(5, 30 + (58 * ((currentPerson-1) % 4)))

        if menuMode == "action" then
            pakemon.rpg_look:drawPointer(240, 28 + (20 * (currentAction-1)))
        end
    else
        love.graphics.print("Looking for hosts...", 20, 20)
    end
end

return StateNetExplorer