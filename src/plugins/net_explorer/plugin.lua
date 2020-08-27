StateNetExplorer = require "plugins.net_explorer.state_net_explorer"
StateNetActionScan = require "plugins.net_explorer.state_net_action_scan"
StateNetActionExploit = require "plugins.net_explorer.state_net_action_exploit"

local net_explorer = { }

function net_explorer:load()
    plugins.menu.main:addItem("Net Diver", function() Gamestate.switch(StateNetExplorer) end)
end

return net_explorer
