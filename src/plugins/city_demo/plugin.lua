StateCityDemo = require "plugins.city_demo.state_city_demo"

local PluginCityDemo = {}

function PluginCityDemo:load()
  plugins.menu.main:addItem("Cyberpunk", function() Gamestate.switch(StateCityDemo) end, 2)
  plugins.credits:add("The city layer images in Cyberpunk demo came from Luis Zuno.")
end

return PluginCityDemo