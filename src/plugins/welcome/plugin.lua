StateWelcome = require "plugins.welcome.state_welcome"

local PluginWelcome = {}

-- this is called when the plugin is loaded
function PluginWelcome:load()
  -- initial state will be StateWelcome
  Gamestate.switch(StateWelcome)
end

return PluginWelcome