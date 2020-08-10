local MenuManager = Class{ }

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
    if button == 'up' then
        self.currentItem =  self.currentItem - 1
        if self.currentItem < 1 then
            self.currentItem = #self.menuItems
        end
    end
    if button == 'down' then
        self.currentItem =  self.currentItem + 1
        if self.currentItem > #self.menuItems then
            self.currentItem = 1
        end
    end
    if button == 'a' or button == 'start' then
        self.menuItems[self.currentItem][2]()
    end
end

function MenuManager:draw()
    for i, menuItem in pairs(self.menuItems) do
        if self.currentItem == i then
            love.graphics.print("•", 10, (i * 15))
        end
        love.graphics.print(menuItem[1 ], 20, (i * 15))
    end
end

return MenuManager
