local MenuState = {}

local menu = MenuManager()

local notImplemented = function()
    print("not implemented.")
end

function MenuState:enter()
    love.graphics.setFont(FontBasic)
    local menuItems = {
        { "Check pakemon's mood", notImplemented },
        { "Informational Video Archive", notImplemented },
        { "Quiz", notImplemented },
        { "About", notImplemented },
        { "Options", notImplemented },
        { "Quit / Reload", function() love.event.quit() end }
    }
    menu:setMenu(menuItems)
end

function MenuState:draw()
    menu:draw()
end

function MenuState:pressed(button)
    menu:pressed(button)
end

return MenuState