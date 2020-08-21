local StatePlaneList = {}

local p
local planes = {}
local currentPlane = null

local menuPlanes

local timerhandle

local function handleExit()
  io.popen('killall -9 dump1090')
  p:close()
end

-- get list of current planes around you 
local function updatePlanes()
  local j = httpGetJson("http://localhost:8080/data.json")
  if j then
    planes = j
    menuPlanes:setTitle(#planes .. " plane" .. (#planes == 1 and "" or "s") .. " found.")
    local menu = {}
    for i,v in pairs(planes) do
      table.insert(menu, {v.hex, function() currentPlane = v end })
    end
    menuPlanes:setMenus({ menu })
  end
end

function StatePlaneList:enter()
  menuPlanes = MenuManager()
  -- needs this in path & permissions
  p = assert(io.popen('dump1090 --net'))
  timerhandle = Timer.every(2, updatePlanes)
  updatePlanes()
end

function StatePlaneList:leave()
  Timer.cancel(timerhandle)
  handleExit()
end

function StatePlaneList:quit()
  handleExit()
end

function StatePlaneList:update(dt)
  menuPlanes:update(dt)
end

function StatePlaneList:draw()
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

function StatePlaneList:pressed(button)
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

return StatePlaneList
