StateNetExplorer = require "plugins.net_explorer.state_net_explorer"

local PluginNetExplorer = {}

function PluginNetExplorer:load()
    plugins.menu.main:addItem("Net Explorer", function() Gamestate.switch(StateNetExplorer) end, 2)
end

return PluginNetExplorer