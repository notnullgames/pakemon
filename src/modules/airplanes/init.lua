StatePlaneMap = require "modules.airplanes.state_plane_map"
StatePlaneList = require "modules.airplanes.state_plane_list"
StatePlaneManager = require "modules.airplanes.state_plane_manager"

local PluginPlane = {}

-- this gets called when the plugin is loaded
function PluginPlane:load()
    table.insert(pakemon.menu.menuItems[2], { "Track Planes", function()  Gamestate.switch(StatePlaneManager) end })
    table.insert(pakemon.menu.menuItems[2], { "Plane Map", function()  Gamestate.switch(StatePlaneMap) end })

    pakemon.credits.text = pakemon.credits.text .. "Dynamic map images were provided by mapbox. Airplane image came from anim8's 1945 demo.\n"
    pakemon.credits.text = pakemon.credits.text .. "dump1090 provides plane radio information.\n"
end

return PluginPlane