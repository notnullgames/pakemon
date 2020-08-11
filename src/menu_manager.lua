local MenuManager = Class{ }

function MenuManager:init(menuItems, title)
    if menuItems then
        self:setMenus(menuItems)
        self:setCurrentMenu(1)
    end
    self:setTitle(title or "Choose one:")
end

-- override the current set of menus
function MenuManager:setMenus(menuItems)
    self.menuItems = menuItems
end

-- override the current title
function MenuManager:setTitle(title)
    self.title = title
end

-- set the current menu-depth
function MenuManager:setCurrentMenu(num)
    self.currentItem = 1
    self.currentMenu = num
end

-- use this in parent to pass presed buttons to this lib
function MenuManager:pressed(button)
    if button == 'up' then
        self.currentItem =  self.currentItem - 1
        if self.currentItem < 1 then
            self.currentItem = #self.menuItems[self.currentMenu]
        end
        SoundMove:play()
    end
    if button == 'down' then
        self.currentItem =  self.currentItem + 1
        if self.currentItem > #self.menuItems[self.currentMenu] then
            self.currentItem = 1
        end
        SoundMove:play()
    end
    
    -- OK
    if button == 'a' or button == 'start' then
        self.menuItems[self.currentMenu][self.currentItem][2]()
        SoundOk:play()
    end

    -- back
    if button == 'b' and self.currentMenu > 1 then
        self.currentMenu = self.currentMenu - 1
        SoundBack:play()
    end
end

-- use this in parent to pass updates
function MenuManager:draw()
    if not self.menuItems or not self.menuItems[self.currentMenu] then
        return
    end

    love.graphics.setFont(FontHeader)
    love.graphics.print(self.title, 10, 10)
    
    love.graphics.setFont(FontBasic)
    -- TODO: add a camera to get scrolling working
    for i, menuItem in pairs(self.menuItems[self.currentMenu]) do
        if self.currentItem == i then
            love.graphics.print("•", 10, (i * 15) + 15)
        end
        love.graphics.print(menuItem[1], 20, (i * 15) + 15)
    end
end

return MenuManager
