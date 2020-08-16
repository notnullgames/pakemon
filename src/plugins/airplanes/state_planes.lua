local StateAirplanes = {}

local p
local planes = {}
local interval = 0
local currentPlane = null

local menuPlanes = MenuManager()

local function updatePlanes()
  local res = {}
  local r = request.send(url)
  if r then
    planes = json.decode(r.body)
    print(r.body)
  end
end

local function handleExit()
  io.popen('killall -9 dump1090-mutability')
  p:close()
end

function StateAirplanes:enter()
  -- needs this in path & permissions
  p = assert(io.popen('dump1090-mutability --net --quiet'))
end

function StateAirplanes:leave()
  handleExit()
end

function StateAirplanes:quit()
  handleExit()
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
        love.graphics.print(i .. ": " .. v, 10, 24 + (y * 12))
      end
      y = y + 1
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
      Gamestate.switch(StateMainMenu)
    end
  else
    if currentPlane then
    else
      menuPlanes:pressed(button)
    end
  end
end

return StateAirplanes