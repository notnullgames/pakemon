StateNotnull = require "plugins.intro.state_notnull"
StateCity = require "plugins.intro.state_city"

local PluginCity = {}

function PluginCity:load()
  -- add credits
  plugins.credits:add("The city layer images in intro came from Luis Zuno.")
  plugins.credits:add('The intro music is "the golden ages" by matthew "4-mat" simmonds')

  -- set initial state to StateNotnull
  Gamestate.switch(StateNotnull)
end

return PluginCity