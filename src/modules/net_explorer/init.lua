StateNetExplorer = require "modules.net_explorer.state_net_explorer"
StateNetActionScan = require "modules.net_explorer.state_net_action_scan"
StateNetActionExploit = require "modules.net_explorer.state_net_action_exploit"

local ModuleNetExplorer = { }

function ModuleNetExplorer:load()
    table.insert(pakemon.menu.menuItems[1], { "Net Diver", function()  Gamestate.switch(StateNetExplorer) end })
end

return ModuleNetExplorer
