local StateGeoMap = {}

-- this comes from portapack mayhem
love.filesystem.mount('modules/geomap/map.zip', 'modules/geomap/map', true)

function asinh (x)
  return math.log(x + math.sqrt(x * x + 1))
end

function coordsToTile(lat, lon, zoom)
  local lat_rad = math.rad(lat)
  local n = 2.0 ^ zoom
  local xtile = math.floor((lon + 180.0) / 360.0 * n)
  local ytile = math.floor((1.0 - asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
  return xtile, ytile
end

function getMapImage(lat, lon, zoom)
  local x,y = coordsToTile(lat, lon, zoom)
  -- todo: get tiles around the tile, and crop it to screen
  return love.graphics.newImage('modules/geomap/map/' .. zoom .. '/' .. x .. '/' .. y .. '.jpg')
end

local mapImage

-- center of map
local lat = 45.512230
local lon = -122.658722
local zoom = 5

function StateGeoMap:enter()
  mapImage = getMapImage(lat, lon, zoom)
end

function StateGeoMap:draw()
  love.graphics.draw(mapImage, 0, 0)
end

function StateGeoMap:pressed(button)
  if button == 'b' then
    Gamestate.switch(StateMainMenu)
  end
end

return StateGeoMap