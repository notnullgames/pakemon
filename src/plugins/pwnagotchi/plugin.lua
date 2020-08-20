StateShowPwnagotchi = require 'plugins.pwnagotchi.state_show_pwnagotchi'

local PluginPwnagotchi = {}

function PluginPwnagotchi:load()
    plugins.menu.main:addItem("Pwnagotchi", function() Gamestate.switch(StateShowPwnagotchi) end)
end

return PluginPwnagotchi