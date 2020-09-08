StateShowPwnagotchi = require 'modules.pwnagotchi.state_show_pwnagotchi'

local PluginPwnagotchi = {}

function PluginPwnagotchi:load()
    table.insert(pakemon.menu.menuItems[2], { "Pwnagotchi", function()  Gamestate.switch(StateShowPwnagotchi) end })
end

return PluginPwnagotchi