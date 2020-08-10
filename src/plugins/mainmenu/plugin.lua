local MenuState = {}

local menu = MenuManager()

-- this tracks where the user is in menuItems
local menuLevel = 1

local notImplemented = function()
    print("not implemented.")
end

-- the array of all the menus & sub-menus
local menuItems = {
    {
        { "Current Mood", notImplemented },
        { "Video Archive", notImplemented },
        { "Quiz", notImplemented },
        { "About", notImplemented },
        { "Options", function() setMenu(2) end },
        { "Quit / Reload", function() love.event.quit() end }
    },
    {
        { "Option 1", notImplemented },
        { "Option 2", notImplemented }
    }
}

-- set the current sub-menu
function setMenu(num)
    menuLevel = num
    menu:setMenu(menuItems[num])
end

function MenuState:enter()
    love.graphics.setFont(FontBasic)
    setMenu(menuLevel)
end

function MenuState:draw()
    menu:draw()
end

function MenuState:pressed(button)
    menu:pressed(button)
    if button == 'b' and menuLevel > 1 then
        menuLevel = menuLevel - 1
        setMenu(menuLevel)
    end
end

return MenuState