-- this is a simple menu example

local StateMenu = {}

local current_selection = 1

local menu = {
  {
    title = "Test 1",
    callback = function () print("test 1") end
  },
  {
    title = "Test 2",
    callback = function () print("test 2") end
  },
  {
    title = "Test 3",
    callback = function () print("test 3") end
  },
  {
    title = "Test 4",
    callback = function () print("test 4") end
  }
}


-- called when a button is pressed
function StateMenu:pressed(button)
  if button == "a" then
    menu[current_selection].callback()
  end
  if button == "b" then
    set_current_state("intro")
  end

  if button == 'down' then
    current_selection = current_selection + 1
  end
  
  if button == 'up' then
    current_selection = current_selection - 1
  end
  
  if current_selection < 1 then
    current_selection = #menu
  elseif current_selection > #menu then
    current_selection = 1
  end
end

-- callled in main draw loop
function StateMenu:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setBackgroundColor( 0.1, 0.1, 0.1, 1 )

  love.graphics.printf("Please choose one:", 20, 20, 300)

  for f,v in pairs(menu) do
    love.graphics.printf(v.title, 40, 40 + ((f-1) * 14), 300)
  end
  
  love.graphics.printf('-', 20, 40 + ((current_selection-1) * 14), 300)
end

return StateMenu
