local StateGeoMap = {}

local mapImage

-- center of map
local lat = 45.512230
local lon = -122.658722
local zoom = 10

-- manage real tile location
local x
local y
local xoffset
local yoffset

function asinh (x)
  return math.log(x + math.sqrt(x * x + 1))
end

-- turn lat/long into x/y for tiled map (like openstreetmap)
function coordsToTile(lat, lon, zoom)
  local lat_rad = math.rad(lat)
  local n = 2.0 ^ zoom
  local xreal = (lon + 180.0) / 360.0 * n
  local yreal = (1.0 - asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n
  local xtile = math.floor(xreal)
  local ytile = math.floor(yreal)
  local xoffset = xreal - xtile
  local yoffset = yreal - ytile
  return xtile, ytile, xoffset, yoffset
end

function updateMapImage()
  x, y, xoffset, yoffset = coordsToTile(lat, lon, zoom)
  -- todo: get tiles around the tile, and crop it to screen
  mapImage = love.graphics.newImage('modules/geomap/tiles/' .. zoom .. '/' .. x .. '/' .. y .. '.jpg')
end

function StateGeoMap:enter()
  updateMapImage()
end

function StateGeoMap:draw()
  love.graphics.setColor(1, 1, 1, 1)
  -- ( drawable, x, y, r, sx, sy, ox, oy )
  love.graphics.draw(mapImage, 0, 0, 0)
  love.graphics.printf(zoom.."X", 0, 0, 320, "right")
end

function StateGeoMap:pressed(button)
  if button == 'b' then
    Gamestate.switch(StateMainMenu)
  end
  
  if button == 'up' then
    zoom = zoom + 1
  end
  if button == 'down' then
    zoom =zoom - 1
  end
  if zoom < 5 then
    zoom = 10
  end
  if zoom > 10 then
    zoom = 5
  end
  updateMapImage()
end

return StateGeoMap