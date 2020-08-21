-- StateRadioDemo = require("plugins.radio.state_radio_demo")

local PluginRadio = {}

function PluginRadio:load()
    plugins.credits:add("Most radio is acheived with luaradio.")
    -- plugins.menu.main:addItem("Listen to 91.5 FM", function() Gamestate.switch(StateRadioDemo) end, 2)
    print("radio disabled until I can figure out luaradio in love")
end

return PluginRadio