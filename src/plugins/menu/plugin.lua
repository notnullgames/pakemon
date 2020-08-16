-- this plugin sets up a main-menu and makes a menu-lib available for everyone

-- setup soem globals
MenuManager = require "plugins.menu.menu_manager"
StateMainMenu = require "plugins.menu.state_main_menu"

local PluginMenu = { main = MenuManager() }

-- called when plugin is loaded
function PluginMenu:load()
    -- main-menu is starting gamestate
    Gamestate.switch(StateMainMenu)
end

return PluginMenu