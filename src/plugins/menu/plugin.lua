-- this plugin sets up a main-menu and makes a menu-lib available for everyone

-- setup some globals
MenuManager = require "plugins.menu.menu_manager"
StateMainMenu = require "plugins.menu.state_main_menu"
StateMenuDemo = require "plugins.menu.state_menu_demo"

local PluginMenu = { main = MenuManager() }

function PluginMenu:load()
    plugins.menu.main:addItem("Demo Menu", function() Gamestate.switch(StateMenuDemo) end, 2)
end

return PluginMenu
