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
    if image then
        love.graphics.draw( image, 0, 40, 0, 1.48
        , 1.48)
    end
end


function StateShowPwnagotchi:pressed(button)
    if button == 'b' then
        Gamestate.switch(StateMainMenu)
    end
end


return StateShowPwnagotchi
