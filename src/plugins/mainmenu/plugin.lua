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
    personality:setMood("sad", "for no reason")
end

local function setMoodHappy()
    personality:setMood("happy", "you found good stuff")
end

local function showMood()
    personality:setMood()
end

local function showCredits()
    Gamestate.switch(StateCredits)
end

local function menuDemo()
    menuMain:setCurrentMenu(3)
end

local function showShort()
    personality:notify("short notication")
end

local function showLong()
    personality:notify("Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. Ich bin Ein Teil von jener Kraft, Die stets das Gute schafft. Es irrt der Mensch, wenn er sie beim Kragen hätte. Ich bin von je der Ordnung Freund gewesen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächtger Schnelle Vom Himmel durch die Welt zur Hölle. Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächt'ger Schnelle Vom Himmel durch die Welt zur Hölle. Ich bin von je der Ordnung Freund gewesen. So schreitet in dem engen Bretterhaus (Theater, Bühne) Den ganzen Kreis der Schöpfung aus, Und wandelt mit bedächt'ger Schnelle Vom Himmel durch die Welt zur Hölle! Ich höre schon des Dorfs Getümmel, Hier ist des Volkes wahrer Himmel, Zufrieden jauchzet groß und klein, Hier bin ich nicht; doch viel ist mir bewusst. Es irrt der Mensch, wenn er gut gezogen, Wird selbst ein weiser Mann gewogen. Gewöhnlich glaubt der Mensch, wenn er sie beim Kragen hätte. Und wandelt mit bedächtger Schnelle Vom Himmel durch die Welt zur Hölle.")
end

function MenuState:enter()
    menuMain:setMenus({
        {
            { "Your Pakémon", showMood },
            { "About", showCredits },
            { "Options", menuOptions },
            { "Demo", menuDemo },
            { "Quit / Reload", menuQuit }
        },
        {
            { "Option 1", notImplemented },
            { "Option 2", notImplemented }
        },
        {
            { "Set Mood to sad", setMoodSad },
            { "Set Mood to happy", setMoodHappy },
            { "Show a short notification", showShort },
            { "Show a long notification", showLong },
        }
    })
end

function MenuState:draw()
    menuMain:draw()
    -- allow notifications to draw over this game-state
    personality:draw()
end

function MenuState:pressed(button)
    menuMain:pressed(button)
end

return MenuState