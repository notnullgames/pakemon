StatePlaneMap = require "plugins.airplanes.state_plane_map"
StatePlaneList = require "plugins.airplanes.state_plane_list"
StatePlaneManager = require "plugins.airplanes.state_plane_manager"

local PluginPlane = {}

-- this gets called when the plugin is loaded
function PluginPlane:load()
    plugins.menu.main:addItem("Track Planes", function() Gamestate.switch(StatePlaneManager) end)
    plugins.menu.main:addItem("Plane Map", function() Gamestate.switch(StatePlaneMap) end, 2)
    plugins.credits:add("Dynamic map images were provided by mapbox. Airplane image came from anim8's 1945 demo.")
    plugins.credits:add("dump1090 provides plane radio information.")
end

return PluginPlane