local MenuState = {}

local function notImplemented()
    print("not implemented.")
end

local function menuOptions()
    menuMain:setCurrentMenu(2)
end

local function menuQuit()
    love.event.quit()
end

function MenuState:enter()
    menuMain:setMenus({
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
    menuMain:draw()
end

function MenuState:pressed(button)
    menuMain:pressed(button)
end

return MenuState