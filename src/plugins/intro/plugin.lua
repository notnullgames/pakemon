StateNotnull = require "plugins.intro.state_notnull"
StateCity = require "plugins.intro.state_city"

local PluginCity = {}

function PluginCity:load()
  -- set initial state to StateNotnull
  Gamestate.switch(StateNotnull)
end

return PluginCity