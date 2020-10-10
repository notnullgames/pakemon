-- register global states
StateGeoMap = require "modules.geomap.state_geomap"

local ModuleGeoMap = {}

function ModuleGeoMap:load()
	-- add a menu item to top-level of main-menu
	table.insert(pakemon.menu.menuItems[2], { "Geo Map", function()  Gamestate.switch(StateGeoMap) end })
end

return ModuleGeoMap