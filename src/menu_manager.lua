local MenuManager = Class{}

function MenuManager:init(menuItems)
    if menuItems then
        self.setMenu(menuItems)
    end
    self.currentItem = 1
end

function MenuManager:setMenu(menuItems)
    self.menuItems = menuItems
end

function MenuManager:pressed(button)
end

function MenuManager:draw()
end

return MenuManager
