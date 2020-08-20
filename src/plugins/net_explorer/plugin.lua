StateNetExplorerDemo = require "plugins.net_explorer.state_net_explorer_demo"

local net_explorer = { }

function net_explorer:load()
    plugins.menu.main:addItem("Net Diver", function() Gamestate.switch(StateNetExplorerDemo) end)
end

return net_explorer
