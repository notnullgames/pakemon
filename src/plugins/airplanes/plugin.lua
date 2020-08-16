StateMapDemo = require "plugins.airplanes.state_map_demo"
StatePlanes = require "plugins.airplanes.state_planes"

local PluginPlane = {}

-- this gets called when the plugin is loaded
function PluginPlane:load()
    plugins.menu.main:addItem("Track Planes", function() Gamestate.switch(StatePlanes) end, 2)
    plugins.menu.main:addItem("Show Map", function() Gamestate.switch(StateMapDemo) end, 2)
    plugins.credits:add("Dynamic map images were provided by mapbox. Airplane image came from anim8's 1945 demo.")
end

return PluginPlane