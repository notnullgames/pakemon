local ModuleCredits = { }

ModuleCredits.text = [[
  was made possible by the labor of love of many people.
  
  Konsumer & Clout made a lot of the code & graphics.
  
  Love2D provides the input/sound/graphics engine.
  
  The cool song you are hearing right now is by Strobe. It's called "Android Assembled". Go check out their other awesome work on the mod-archive.
  
]]

-- register global states
StateCredits = require "modules.credits.state_credits"

function ModuleCredits:load()
	-- add a menu item to top-level of main-menu
	table.insert(pakemon.menu.menuItems[1], { "Credits", function()  Gamestate.switch(StateCredits) end })
end



return ModuleCredits