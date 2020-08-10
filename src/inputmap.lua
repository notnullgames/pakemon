--- reusable map for joystiuc & keyboard, for gpi gameby-like pi
--- this simplifies input into a single callback for keys & gamepad

-- override these
function input_pressed(button)
end
function input_released(button)
end

function love.gamepadpressed(joystick, button)
   -- global full-exit on retropie is start+select
  if joystick and joystick:isGamepadDown('start') and joystick:isGamepadDown('back') then
    love.event.quit()
  end
  if button == 'dpup' then
    input_pressed('up')
  end
  if button == 'dpdown' then
    input_pressed('down')
  end
  if button == 'dpleft' then
    input_pressed('left')
  end
  if button == 'dpright' then
    input_pressed('right')
  end
  if button == 'a' then
    input_pressed('a')
  end
  if button == 'b' then
    input_pressed('b')
  end
  if button == 'x' then
    input_pressed('x')
  end
  if button == 'y' then
    input_pressed('y')
  end
  if button == 'start' then
    input_pressed('start')
  end
  if button == 'back' then
    input_pressed('back')
  end
  if button == 'leftshoulder' then
    input_pressed('l')
  end
  if button == 'rightshoulder' then
    input_pressed('r')
  end
end

function love.keypressed(key, code)
  -- global full-exit on retropie is start+select
  if love.keyboard.isDown('return') and love.keyboard.isDown('escape') then
    love.event.quit()
  end
  if key == 'up' then
    input_pressed('up')
  end
  if key == 'down' then
    input_pressed('down')
  end
  if key == 'left' then
    input_pressed('left')
  end
  if key == 'right' then
    input_pressed('right')
  end
  if key == 'z' then
    input_pressed('a')
  end
  if key == 'x' then
    input_pressed('b')
  end
  if key == 'a' then
    input_pressed('x')
  end
  if key == 's' then
    input_pressed('y')
  end
  if key == 'return' then
    input_pressed('start')
  end
  if key == 'escape' then
    input_pressed('back')
  end
  if key == 'pageup' then
    input_pressed('l')
  end
  if key == 'pagedown' then
    input_pressed('r')
  end
end

function love.gamepadreleased(joystick, button)
  if button == 'dpup' then
    input_released('up')
  end
  if button == 'dpdown' then
    input_released('down')
  end
  if button == 'dpleft' then
    input_released('left')
  end
  if button == 'dpright' then
    input_released('right')
  end
  if button == 'a' then
    input_released('a')
  end
  if button == 'b' then
    input_released('b')
  end
  if button == 'x' then
    input_released('x')
  end
  if button == 'y' then
    input_released('y')
  end
  if button == 'start' then
    input_released('start')
  end
  if button == 'back' then
    input_released('back')
  end
  if button == 'leftshoulder' then
    input_released('l')
  end
  if button == 'rightshoulder' then
    input_released('r')
  end
end

function love.keyreleased(key, code)
  if key == 'up' then
    input_released('up')
  end
  if key == 'down' then
    input_released('down')
  end
  if key == 'left' then
    input_released('left')
  end
  if key == 'right' then
    input_released('right')
  end
  if key == 'z' then
    input_released('a')
  end
  if key == 'x' then
    input_released('b')
  end
  if key == 'a' then
    input_released('x')
  end
  if key == 's' then
    input_released('y')
  end
  if key == 'return' then
    input_released('start')
  end
  if key == 'escape' then
    input_released('back')
  end
  if key == 'pageup' then
    input_released('l')
  end
  if key == 'pagedown' then
    input_released('r')
  end
end