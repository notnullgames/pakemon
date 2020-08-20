local StateNetExplorer = {}

local SoundMove = love.audio.newSource("plugins/net_explorer/sounds/move.wav", "static")
local SoundAction = love.audio.newSource("plugins/net_explorer/sounds/action.wav", "static")
local SoundSelect = love.audio.newSource("plugins/net_explorer/sounds/select.wav", "static")

local faces = {}
for i=1,16 do
    table.insert(faces, love.graphics.newImage("plugins/net_explorer/images/person".. i ..".png"))
end

local pointer =  love.graphics.newImage('plugins/net_explorer/images/pointer.png')

local actions = {
    "Item",
    "Magic",
    "Equip",
    "Status",
    "Form",
    "Change",
    "Custom",
    "Save"
}

-- things that track current state
local hosts = {}
local menuMode = "person"
local currentPerson = 1
local currentAction = 1
local timerhandle

-- draw 1 person
local function drawOnePerson(y, face, hostname, ip, mac)
    love.graphics.setFont(FontBasic)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(face, 20, 10 + (y-1) * 58, 0, 0.5, 0.5)
    love.graphics.print(shortenText(hostname, 22), 80, 10 + (y-1) * 58)
    love.graphics.print(shortenText(ip, 22), 80, 28 + (y-1) * 58)
    love.graphics.print(shortenText(mac, 22), 80, 44 + (y-1) * 58)
end

-- draw a blue box with white outline
local function drawBox(x, y, width, height)
    love.graphics.setLineWidth(2)
    love.graphics.setColor(0.039, 0, 0.39, 1)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.rectangle("line", x, y, width, height)
end

-- draw the actions menu
local function drawActions()
    love.graphics.setFont(FontDefault)
    love.graphics.setColor(1, 1, 1, 1)
    for i, action in pairs(actions) do
        love.graphics.print(action, 260, 25 + (i-1) * 20)
    end
end

-- draw pointer for current person or action
local function drawPointer()
    if menuMode == "person" then
        love.graphics.draw(pointer, 5, 30 + (58 * ((currentPerson-1) % 4)))
    else
        love.graphics.draw(pointer, 240, 28 + (20 * (currentAction-1)))
    end
end

-- play the menu-move sound
local function menuMoveSound()
    SoundMove:stop()
    SoundMove:play()
end

-- mac address to a sortable decimal
local function macToDec(mac)
    return tonumber('0x' .. string.gsub(mac, ":", ""))
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

-- put your handler here. You have access to the host and the action
local function handleAction(actionName, host)
    print("action:", actionName, dump(host))
end

function StateNetExplorer:enter()
    timerhandle = Timer.every(2, updateHosts)
    updateHosts()
end

function StateNetExplorer:leave()
    Timer.cancel(timerhandle)
end

function StateNetExplorer:update(dt)
end


function StateNetExplorer:pressed(button)
    if menuMode == "person" then
        if button == "b" then
            Gamestate.switch(StateMainMenu)
        end
        if button == "a" and #hosts > 0 then
            menuMode = "action"
            SoundSelect:play()
        end
        if button == "up" and #hosts > 0 then
            currentPerson = currentPerson - 1
            menuMoveSound()
        end
        if button == "down" and #hosts > 0 then
            currentPerson = currentPerson + 1
            menuMoveSound()
        end
    else
        if button == "b" then
            SoundSelect:play()
            menuMode = "person"
        end
        if button == "a" then
            SoundAction:play()
            handleAction(actions[currentAction], hosts[currentPerson])
        end
        if button == "up" then
            currentAction = currentAction - 1
            menuMoveSound()
        end
        if button == "down" then
            currentAction = currentAction + 1
            menuMoveSound()
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
    drawBox(0, 0, 240, 240)
    drawBox(240, 0, 80, 240)

    local p = math.floor((currentPerson-1) / 4)
    local o = p * 4

    for i = 1,4 do
        local t = i + o
        local host = hosts[t]
        if host then
            drawOnePerson(i, faces[(t % #faces) + 1], host.hostname, host.ipv4, host.mac )
        end
    end    
    
    drawActions()

    if #hosts > 0 then
        drawPointer()
    else
        love.graphics.setFont(FontBasic)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Looking for hosts...", 20, 20)
    end
end

return StateNetExplorer