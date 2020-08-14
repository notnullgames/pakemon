local StateAirplanes = {}

local http = require "socket.http"

local p
local planes = {}
local interval = 0
local currentPlane = null

local menuPlanes = MenuManager()

local function updatePlanes()
  local res = {}
  local r, c, h, s = http.request{
    url = "http://localhost:8080/dump1090/data.json",
    sink = ltn12.sink.table(res)
  }
  if res and res[1] then
    planes = json.decode(res[1])
  end
end

function StateAirplanes:enter()
  p = assert(io.popen('dump1090 --net --quiet'))
end

function StateAirplanes:leave()
  -- TODO: figure out why it hangs on exit
  p:close()
end

function StateAirplanes:update(dt)
  if (interval % 100 == 0) then
    updatePlanes()
    local p = "s"
    if #planes == 1 then
      p=""
    end
    menuPlanes:setTitle(#planes .. " plane" .. p .. " found.")
    -- TODO: check that it's really differnt so it doesn't reset menu
    local menu = {}
    for i,v in pairs(planes) do
      table.insert(menu, {v.hex, function() currentPlane = v end })
    end
    menuPlanes:setMenus({ menu })
  end
  interval = interval + 1
  menuPlanes:update(dt)
end

function StateAirplanes:draw()
  if currentPlane then
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(FontHeader)
    love.graphics.print(currentPlane.hex, 10, 10)
    love.graphics.setFont(FontBasic)

    local y = 0
    for i,v in pairs(currentPlane) do
      if i ~= "hex" then
        love.graphics.print(i .. ": " .. v, 10, 20 + (y * 12))
      end
    end
  else
    menuPlanes:draw()
  end
end

function StateAirplanes:pressed(button)
  if button == 'b' then
    if currentPlane then
      currentPlane = nil
    else
      Gamestate.switch(StateMenu)
    end
  else
    if currentPlane then
    else
      menuPlanes:pressed(button)
    end
  end
end

return StateAirplanes