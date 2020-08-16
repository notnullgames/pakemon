StateCity = require "plugins.intro.state_city"

local PluginCity = {}

function PluginCity:load()
  plugins.menu.main:addItem("State City", function() Gamestate.switch(StateCity) end, 2)
end

return PluginCity