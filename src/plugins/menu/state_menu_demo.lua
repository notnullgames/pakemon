local StateMenuDemo = {}

local demoMenu = MenuManager()

local menuitems = {
    {
        { "Item A", function()  demoMenu:setCurrentMenu(2) end },
        { "Item B", function()  demoMenu:setCurrentMenu(2) end }
    },
    {
        { "Item A - 1", function()  demoMenu:setCurrentMenu(3) end },
        { "Item A - 2", function()  demoMenu:setCurrentMenu(3) end },
        { "Item A - 3", function()  demoMenu:setCurrentMenu(3) end }
    },
    {
        { "sad", function()  plugins.personality:setMood("sad", "just testing") end },
        { "happy", function() plugins.personality:setMood("happy", "just testing") end },
    }
}

function StateMenuDemo:enter()
    demoMenu:setTitle("DEMO MENU")
    demoMenu:setMenus(menuitems)
end

function StateMenuDemo:draw()
    demoMenu:draw()
end

function StateMenuDemo:pressed(button)
    if button == 'b' and demoMenu.currentMenu == 1 then
        Gamestate.switch(StateMainMenu)
    end
    demoMenu:pressed(button)
end

return StateMenuDemo