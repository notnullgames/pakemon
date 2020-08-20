StateNetExplorer = require "plugins.net_explorer.state_net_explorer"

local net_explorer = { }

function net_explorer:load()
    plugins.menu.main:addItem("Net Diver", function() Gamestate.switch(StateNetExplorer) end)
end

return net_explorer
