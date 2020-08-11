local MenuState = {}

local menu

local function notImplemented()
    print("not implemented.")
end

local function menuOptions()
    menu:setCurrentMenu(2)
end

local function menuQuit()
    love.event.quit()
end

function MenuState:enter()
    menu = MenuManager({
        {
            { "Current Mood", notImplemented },
            { "Video Archive", notImplemented },
            { "Quiz", notImplemented },
            { "About", notImplemented },
            { "Options", menuOptions },
            { "Quit / Reload", menuQuit }
        },
        {
            { "Option 1", notImplemented },
            { "Option 2", notImplemented }
        }
    })
end

function MenuState:draw()
    menu:draw()
end

function MenuState:pressed(button)
    menu:pressed(button)
end

return MenuState