-- this will be another address for other people
local url = 'http://konsumagotchi.local:8080/'

local StateShowPwnagotchi = {}

local timerhandle
local image

function StateShowPwnagotchi:enter()
    -- setup a poling timer
    timerhandle = Timer.every(2, function()
        print('requesting image')
        image = httpGetImage(url .. 'ui', 'pwnagotchi.png', 'changeme', 'changeme')
    end)
    image =  httpGetImage(url .. 'ui', 'pwnagotchi.png', 'changeme', 'changeme')
end

function StateShowPwnagotchi:leave()
    -- remove the timer on exit
    Timer.cancel(timerhandle)
end

function StateShowPwnagotchi:draw()
    love.graphics.setColor(1, 1, 1, 1)
    if image then
        love.graphics.rectangle("fill", 0, 0, 320, 240)
        love.graphics.draw( image, 0, 40, 0, 1.48, 1.48)
    else
        love.graphics.setFont(FontBasic)
        love.graphics.print("Loading your pwnigotchi...", 60, 100)
    end
end


function StateShowPwnagotchi:pressed(button)
    if button == 'b' then
        Gamestate.switch(StateMainMenu)
    end
end


return StateShowPwnagotchi
