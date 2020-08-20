StateRpgMenuDemo = require "plugins.rpgmenu.state_rpg_menu_demo"

local RpgMenu = { }

function RpgMenu:load()
    plugins.menu.main:addItem("RPG Menu", function() Gamestate.switch(StateRpgMenuDemo) end, 2)
end

return RpgMenu
