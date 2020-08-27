StateNetExplorer = require "plugins.net_explorer.state_net_explorer"
StateNetActionMenu = require "plugins.net_explorer.state_net_action_menu"
StateNetActionMenu = require "plugins.net_explorer.state_net_action_syn"

local net_explorer = { }

function net_explorer:load()
    plugins.menu.main:addItem("Net Diver", function() Gamestate.switch(StateNetExplorer) end)
end

return net_explorer
