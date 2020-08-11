local MenuManager = Class{ }

function MenuManager:init(menuItems, title)
    if menuItems then
        self:setMenus(menuItems)
    end
    self:setTitle(title or "Choose one:")
    self.oldMenu = {}
    self.camera = Camera(160, 120)
end

-- override the current set of menus
function MenuManager:setMenus(menuItems)
    self.menuItems = menuItems
    self:setCurrentMenu(1)
end

-- override the current title
function MenuManager:setTitle(title)
    self.title = title
end

-- set the current menu-depth
function MenuManager:setCurrentMenu(num)
    self.currentItem = 1
    table.insert(self.oldMenu, (self.currentMenu or 0))
    self.currentMenu = num
end

-- use this in parent to pass presed buttons to this lib
function MenuManager:pressed(button)
    if button == 'up' then
        self.currentItem =  self.currentItem - 1
        if self.currentItem < 1 then
            self.currentItem = #self.menuItems[self.currentMenu]
        end
        SoundMove:stop()
        SoundMove:play()
    end
    if button == 'down' then
        self.currentItem =  self.currentItem + 1
        if self.currentItem > #self.menuItems[self.currentMenu] then
            self.currentItem = 1
        end
        SoundMove:stop()
        SoundMove:play()
    end
    
    -- OK
    if button == 'a' or button == 'start' then
        self.menuItems[self.currentMenu][self.currentItem][2]()
        SoundOk:play()
    end

    -- back
    if button == 'b' and self.currentMenu > 1 then
        self.currentItem = 1
        self.currentMenu = table.remove (self.oldMenu, #self.oldMenu)
        SoundBack:play()
    end
end

function MenuManager:update(dt)
    if self.currentItem > 14 then
        self.camera:lookAt(160, 120 + (self.currentItem - 14) * 15 )
    else
        self.camera:lookAt(160, 120)
    end
end

-- use this in parent to pass updates
function MenuManager:draw()
    if not self.menuItems or not self.menuItems[self.currentMenu] then
        return
    end
    
    self.camera:attach()
    love.graphics.setFont(FontBasic)
    for i, menuItem in pairs(self.menuItems[self.currentMenu]) do
        if self.currentItem == i then
            love.graphics.print("•", 10, (i * 15) + 15)
        end
        love.graphics.print(menuItem[1], 20, (i * 15) + 15)
    end
    self.camera:detach()

    -- this covers up the outside of self.camera area
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", 0, 0, 320, 30 )

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(FontHeader)
    love.graphics.print(self.title, 10, 10)
end

return MenuManager
