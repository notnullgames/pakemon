local StateGeoMap = {}

-- this comes from portapack mayhem
love.filesystem.mount('modules/geomap/world_map.zip', 'modules/geomap', true)
local mapData = love.filesystem.newFileData('modules/geomap/world_map.bin')

local function getMapImage(lat, long, alt)
  local map = love.image.newImageData(320, 240)
  -- TODO: insert pixels (in RRR00GGG000BB000 format) from mapData into map
  -- map.setPixel(x,y,r,g,b,a) rgb is 0-1
  -- this is not right, but basic idea:
  for x=1,320 do
    for y=1,240 do
      local d = love.data.unpack('BBBBBBBBBBBBBBB', mapData, x*y*15)
      local r = d[1] + d[2] + d[3]
      local g = d[6] + d[7] + d[8]
      local b = d[12] + d[13]
      map.setPixel(x, y, r, g, b, 1)
    end
  end
  return love.graphics.newImage(map)
end

local mapImage

-- center of map
local lat = 45.512230
local long = -122.658722
local alt = 8500

function StateGeoMap:enter()
  mapImage = getMapImage(lat, long, alt)
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