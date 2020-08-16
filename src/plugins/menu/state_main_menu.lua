-- gamestate for showing main menu

local StatMaineMenu = {}

function StatMaineMenu:draw()
    plugins.menu.main:draw()
end

function StatMaineMenu:pressed(button)
    plugins.menu.main:pressed(button)
end

return StatMaineMenu