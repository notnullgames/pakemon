StateNetDemo = require "plugins.net_demo.state_net_demo"

local PluginNetDemo = {}

function PluginNetDemo:load()
    plugins.menu.main:addItem("Network", function() Gamestate.switch(StateNetDemo) end, 2)
end

return PluginNetDemo