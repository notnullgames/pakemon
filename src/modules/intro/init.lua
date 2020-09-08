-- register global gamestates
StateNotnull = require "modules.intro.state_notnull"
StateCity = require "modules.intro.state_city"

local ModuleIntro = {}

function ModuleIntro:load()
	-- add credits
	-- pakemon.credits:add("The city layer images in intro came from Luis Zuno.")
	-- pakemon.credits:add('The intro music is "the golden ages" by matthew "4-mat" simmonds')

	-- set initial state to StateNotnull
	Gamestate.switch(StateNotnull)
end

return ModuleIntro