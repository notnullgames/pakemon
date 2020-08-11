-- this sets up global stuff that other people can use
menuMain = MenuManager()

local MenuState = {}

local StateCredits = require "plugins.mainmenu.credits"

local function notImplemented()
    print("not implemented.")
end

local function menuOptions()
    menuMain:setCurrentMenu(2)
end

local function menuQuit()
    love.event.quit()
end

local function setMoodSad()
    showMood("sad")
end

local function setMoodHappy()
    showMood("happy")
end

local function showCredits()
    Gamestate.switch(StateCredits)
end

function MenuState:enter()
    menuMain:setMenus({
        {
            { "Current Mood", showMood },
            { "Set Mood to sad", setMoodSad },
            { "Set Mood to happy", setMoodHappy },
            { "About", showCredits },
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