-- this plugin sets up a main-menu and makes a menu-lib available for everyone

-- setup some globals
MenuManager = require "plugins.menu.menu_manager"
StateMainMenu = require "plugins.menu.state_main_menu"

local PluginMenu = { main = MenuManager() }

return PluginMenu