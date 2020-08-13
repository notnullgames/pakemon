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
    print(res[1])
  end
end

function StateAirplanes:enter()
  -- needs this in path & permissions
  p = assert(io.popen('dump1090 --net --quiet'))
end

function StateAirplanes:leave()
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
    -- squak
    -- flight
    -- lat
    -- lon
    -- validposition
    -- altitude
    -- vert_rate
    -- track
    -- validtrack
    -- speed
    -- messages
    -- seen
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