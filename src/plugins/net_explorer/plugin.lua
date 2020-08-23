StateNetExplorer = require "plugins.net_explorer.state_net_explorer"
StateNetActionSyn = require "plugins.net_explorer.state_net_action_syn"
StateNetActionNmap = require "plugins.net_explorer.state_net_action_nmap"

local net_explorer = { }

function net_explorer:load()
    plugins.menu.main:addItem("Net Diver", function() Gamestate.switch(StateNetExplorer) end)
end

return net_explorer
