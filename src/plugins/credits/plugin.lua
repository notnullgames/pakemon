-- This plugin gives plugins a way to add to the credits screen

-- global things for other plugins to use
StateCredits = require "plugins.credits.state_credits"

local PluginCredits = { credits = "" }

-- called when the plugin is initially loaded
function PluginCredits:load()
    plugins.menu.main:addItem("About", function() Gamestate.switch(StateCredits) end)
end

function PluginCredits:add(credit)
    self.credits = self.credits .. "\n\n" .. credit
end

return PluginCredits