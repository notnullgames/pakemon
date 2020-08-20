local StateRpgMenuDemo = {}

local faces = {
    love.graphics.newImage('plugins/rpgmenu/person1.png'),
    love.graphics.newImage('plugins/rpgmenu/person2.png'),
    love.graphics.newImage('plugins/rpgmenu/person3.png'),
    love.graphics.newImage('plugins/rpgmenu/person4.png'),
    love.graphics.newImage('plugins/rpgmenu/person5.png'),
    love.graphics.newImage('plugins/rpgmenu/person6.png'),
    love.graphics.newImage('plugins/rpgmenu/person7.png'),
    love.graphics.newImage('plugins/rpgmenu/person8.png'),
}

local pointer =  love.graphics.newImage('plugins/rpgmenu/pointer.png')

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

local hosts = {
    {
        hostname = "ABABABABABABABABABABABABABABABA",
        ipv4 = "192.168.0.4",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "BBOOOKOKKOKOKOKOOKOKO",
        ipv4 = "192.168.0.5",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "OYTIYTITUTUYTUTUTUTUTUYTUTUTUTUT",
        ipv4 = "192.168.0.6",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "mnbvxishdfkjhsdkfhksdhfkshdkfhskdf",
        ipv4 = "192.168.0.7",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "hsdkahsdkjahksdhakdhakshdkahsdkahsdk",
        ipv4 = "192.168.0.8",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "ghjghjghjghjghjghjghjghj",
        ipv4 = "192.168.0.9",
        mac = "98:48:27:3f:be:d6"
    },
    {
        hostname = "weqweqweqweqweqweqweqweqweqweqweqwewe",
        ipv4 = "192.168.0.10",
        mac = "98:48:27:3f:be:d6"
    }
}

-- things that track current state
local menuMode = "person"
local currentPerson = 1
local currentAction = 1

-- draw 1 person
local function drawOnePerson(y, face, hostname, ip, mac)
    love.graphics.setFont(FontBasic)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(face, 20, 25 + (y-1) * 60, 0, 0.5, 0.5)
    love.graphics.print(shortenText(hostname, 22), 80, 24 + (y-1) * 60)
    love.graphics.print(shortenText(ip, 22), 80, 42 + (y-1) * 60)
    love.graphics.print(shortenText(mac, 22), 80, 60 + (y-1) * 60)
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
        love.graphics.draw(pointer, 5, 45 + (60 * (currentPerson-1)))
    else
        love.graphics.draw(pointer, 240, 28 + (20 * (currentAction-1)))
    end
end

local function handleAction(actionName, person)
    print("action:", actionName, dump(person))
end

function StateRpgMenuDemo:load()
end

function StateRpgMenuDemo:update(dt)
end

function StateRpgMenuDemo:pressed(button)
    if menuMode == "person" then
        if button == "b" then
            Gamestate.switch(StateMainMenu)
        end
        if button == "a" then
            menuMode = "action"
        end
        if button == "up" then
            currentPerson = currentPerson - 1
        end
        if button == "down" then
            currentPerson = currentPerson + 1
        end
    else
        if button == "b" then
            menuMode = "person"
        end
        if button == "a" then
            handleAction(actions[currentAction], hosts[currentPerson])
        end
        if button == "up" then
            currentAction = currentAction - 1
        end
        if button == "down" then
            currentAction = currentAction + 1
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

function StateRpgMenuDemo:draw()
    drawBox(0, 0, 240, 240)
    drawBox(240, 0, 80, 240)
    -- TODO: need to sort by mac to keep better order
    for i, host in pairs(hosts) do
        drawOnePerson(i, faces[(i % #faces) + 1], host.hostname, host.ipv4, host.mac)
    end
    drawActions()
    drawPointer()
end

return StateRpgMenuDemo