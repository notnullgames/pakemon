local StateMainMenu = {}

local camera

function StateMainMenu:enter()
    camera = Camera(160, 120)
end

function StateMainMenu:update(dt)
    if pakemon.menu.currentItem > 14 then
        camera:lookAt(160, 120 + (pakemon.menu.currentItem - 14) * 15 )
    else
        camera:lookAt(160, 120)
    end
end

function StateMainMenu:draw()
	if not pakemon.menu.menuItems or not pakemon.menu.menuItems[pakemon.menu.currentMenu] then
        return
    end
    
    camera:attach()
    love.graphics.setColor(1,1,1,1)
    for i, menuItem in pairs(pakemon.menu.menuItems[pakemon.menu.currentMenu]) do
        if pakemon.menu.currentItem == i then
            love.graphics.print("•", 10, (i * 15) + 15)
        end
        love.graphics.print(menuItem[1], 20, (i * 15) + 15)
    end
    camera:detach()

    -- this covers up the outside of camera area
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle( "fill", 0, 0, 320, 30 )
end

function StateMainMenu:pressed(button)
    if button == 'up' then
        pakemon.menu.currentItem =  pakemon.menu.currentItem - 1
        if pakemon.menu.currentItem < 1 then
            pakemon.menu.currentItem = #pakemon.menu.menuItems[pakemon.menu.currentMenu]
        end
        SoundMove:stop()
        SoundMove:play()
    end
    if button == 'down' then
        pakemon.menu.currentItem =  pakemon.menu.currentItem + 1
        if pakemon.menu.currentItem > #pakemon.menu.menuItems[pakemon.menu.currentMenu] then
            pakemon.menu.currentItem = 1
        end
        SoundMove:stop()
        SoundMove:play()
    end
    
    -- OK
    if button == 'a' or button == 'start' then
        pakemon.menu.menuItems[pakemon.menu.currentMenu][pakemon.menu.currentItem][2]()
        SoundOk:play()
    end

    -- back
    if button == 'b' and pakemon.menu.currentMenu > 1 then
        pakemon.menu.currentItem = 1
        pakemon.menu.currentMenu = table.remove (pakemon.menu.oldMenu, #pakemon.menu.oldMenu)
        SoundBack:play()
    end
end

return StateMainMenu